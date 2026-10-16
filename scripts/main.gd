extends Node3D
var player: LifeSimPlayer
var cam: Camera3D
var humanoid: LifeSimCharacterVisual
var yaw := 0.3
var pitch := -0.35
var paused := false
var targets: Array[StaticBody3D] = []
var focused: StaticBody3D
var object_states: Dictionary = {}
var interact_button: Button
var feedback: Label
var action_engine: LifeSimActionEngine
var save_elapsed: float = 0.0
var _manual_axis: Vector2 = Vector2.ZERO
var navigation: LifeSimRoomPathfinder
var auto_path: Array[Vector3] = []
var auto_marker: MeshInstance3D

func _ready() -> void:
    var ground := StaticBody3D.new()
    var g := CollisionShape3D.new()
    var b := BoxShape3D.new()
    b.size = Vector3(14, 0.2, 14)
    g.shape = b
    g.position.y = -0.1
    ground.add_child(g)
    var floor_mesh := MeshInstance3D.new()
    var floor_box := BoxMesh.new()
    floor_box.size = b.size
    floor_mesh.mesh = floor_box
    floor_mesh.position.y = -0.1
    ground.add_child(floor_mesh)
    add_child(ground)
    _build_room()
    player = LifeSimPlayer.new()
    var col := CollisionShape3D.new()
    var capsule := CapsuleShape3D.new()
    capsule.height = 1.9
    capsule.radius = 0.35
    col.shape = capsule
    col.position.y = 0.95
    player.add_child(col)
    var body := Node3D.new()
    body.name = "Visual"
    humanoid = LifeSimCharacterVisual.new()
    humanoid.name = "CharacterVisual"
    body.add_child(humanoid)
    player.add_child(body)
    add_child(player)
    cam = Camera3D.new()
    add_child(cam)
    cam.current = true
    var sun := DirectionalLight3D.new()
    sun.rotation_degrees = Vector3(-48, -35, 0)
    sun.light_energy = 0.85
    add_child(sun)
    var ambient := WorldEnvironment.new()
    var environment := Environment.new()
    environment.background_mode = Environment.BG_COLOR
    environment.background_color = Color(0.19, 0.23, 0.29)
    environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
    environment.ambient_light_color = Color(0.77, 0.82, 0.90)
    environment.ambient_light_energy = 0.8
    ambient.environment = environment
    add_child(ambient)
    var layer := CanvasLayer.new()
    add_child(layer)
    var hud := LifeSimMobileControls.new()
    layer.add_child(hud)
    hud.movement_changed.connect(func(a: Vector2) -> void:
        _manual_axis = a
        player.input_axis = a
        if a.length_squared() > 0.02:
            _cancel_navigation()
    )
    hud.camera_dragged.connect(_orbit)
    hud.destination_tapped.connect(_tap_destination)
    navigation = LifeSimRoomPathfinder.new()
    _create_destination_marker()
    hud.pause_toggled.connect(_pause)
    action_engine = LifeSimActionEngine.new()
    add_child(action_engine)
    action_engine.action_event.connect(_on_action_event)
    action_engine.counts = LifeSimSaveManager.read_counts()
    var restored: Dictionary = LifeSimSaveManager.read_world()
    if not restored.is_empty():
        player.global_position = restored["position"]
        yaw = restored["yaw"]
        pitch = restored["pitch"]
    _setup_interaction_ui(layer)

func _physics_process(delta: float) -> void:
    if paused: return
    _advance_navigation()
    action_engine.advance(delta)
    save_elapsed += delta
    if save_elapsed >= 3.0:
        save_elapsed = 0.0
        _save_world()
    _refresh_focus()
    humanoid.update_locomotion(delta, Vector2(player.velocity.x, player.velocity.z).length())
    player.camera_yaw = yaw
    var focus := player.global_position + Vector3.UP * 1.2
    var ray := Vector3(sin(yaw)*cos(pitch), -sin(pitch), cos(yaw)*cos(pitch))
    var wanted: Vector3 = focus + ray * 6.0
    var space: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
    var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(focus, wanted)
    query.exclude = [player.get_rid()]
    var hit: Dictionary = space.intersect_ray(query)
    if not hit.is_empty():
        var along: float = focus.distance_to(hit["position"])
        wanted = focus + ray * maxf(0.45, along - 0.3)
    # Snap inward on collisions so smoothing cannot leave the camera embedded in a wall.
    if not hit.is_empty() or cam.global_position.distance_to(wanted) > 8.0:
        cam.global_position = wanted
    else:
        cam.global_position = cam.global_position.lerp(wanted, minf(1.0, delta * 9.0))
    cam.look_at(focus)

func _orbit(d: Vector2) -> void:
    yaw -= d.x * 0.006
    pitch = clampf(pitch - d.y * 0.004, -1.12, -0.12)

func _pause() -> void:
    paused = not paused
    player.set_physics_process(not paused)
    player.input_axis = Vector2.ZERO
    _manual_axis = Vector2.ZERO
    _cancel_navigation()

func _create_destination_marker() -> void:
    auto_marker = MeshInstance3D.new()
    auto_marker.name = "DestinationMarker"
    var disc := CylinderMesh.new()
    disc.top_radius = 0.28
    disc.bottom_radius = 0.28
    disc.height = 0.025
    auto_marker.mesh = disc
    var mat := StandardMaterial3D.new()
    mat.albedo_color = Color(0.25, 0.95, 0.65, 0.85)
    mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
    auto_marker.material_override = mat
    auto_marker.visible = false
    add_child(auto_marker)

func _cancel_navigation() -> void:
    auto_path.clear()
    if auto_marker != null:
        auto_marker.visible = false

func _tap_destination(screen_position: Vector2) -> void:
    if paused or cam == null or player == null:
        return
    var origin: Vector3 = cam.project_ray_origin(screen_position)
    var direction: Vector3 = cam.project_ray_normal(screen_position)
    if absf(direction.y) < 0.0001:
        return
    var distance: float = -origin.y / direction.y
    if distance <= 0.0 or distance > 100.0:
        return
    var target: Vector3 = origin + direction * distance
    var path: Array[Vector3] = navigation.route(player.global_position, target)
    if path.is_empty():
        return
    auto_path = path
    auto_marker.position = Vector3(target.x, 0.04, target.z)
    auto_marker.visible = true

func _advance_navigation() -> void:
    var kb: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    if kb.length_squared() > 0.02 or _manual_axis.length_squared() > 0.02:
        if not auto_path.is_empty():
            _cancel_navigation()
        return
    if auto_path.is_empty():
        return
    while not auto_path.is_empty() and player.global_position.distance_to(auto_path[0]) < 0.28:
        auto_path.pop_front()
    if auto_path.is_empty():
        player.input_axis = Vector2.ZERO
        auto_marker.visible = false
        return
    var delta_pos: Vector3 = auto_path[0] - player.global_position
    delta_pos.y = 0.0
    var world_motion := delta_pos.normalized()
    var local_motion: Vector3 = Basis(Vector3.UP, -yaw) * world_motion
    player.input_axis = Vector2(local_motion.x, local_motion.z)

func _build_room() -> void:
    # Light public procedural room perimeter; collision prevents leaving the platform.
    _box_prop(Vector3(0.0, 1.5, -7.0), Vector3(14.0, 3.0, 0.35), Color(0.30, 0.38, 0.44))
    _box_prop(Vector3(-7.0, 1.5, 0.0), Vector3(0.35, 3.0, 14.0), Color(0.30, 0.38, 0.44))
    _box_prop(Vector3(7.0, 1.5, 0.0), Vector3(0.35, 3.0, 14.0), Color(0.30, 0.38, 0.44))
    _box_prop(Vector3(0.0, 1.5, 7.0), Vector3(14.0, 3.0, 0.35), Color(0.30, 0.38, 0.44))
    # Simple furniture silhouettes, no third-party assets.
    _box_prop(Vector3(3.4, 0.4, -2.6), Vector3(2.2, 0.8, 1.0), Color(0.33, 0.53, 0.58), "Rest Bench")
    _box_prop(Vector3(-3.0, 0.45, -2.6), Vector3(1.6, 0.9, 0.8), Color(0.50, 0.38, 0.29), "Training Box")

func _box_prop(center: Vector3, size: Vector3, tint: Color, interact_name: String = "") -> void:
    var body := StaticBody3D.new()
    body.position = center
    body.name = interact_name if interact_name != "" else "Room Wall"
    if interact_name != "":
        targets.append(body)
        object_states[interact_name] = 0
    var collision := CollisionShape3D.new()
    var shape := BoxShape3D.new()
    shape.size = size
    collision.shape = shape
    body.add_child(collision)
    var visual := MeshInstance3D.new()
    var mesh := BoxMesh.new()
    mesh.size = size
    visual.mesh = mesh
    var mat := StandardMaterial3D.new()
    mat.albedo_color = tint
    mat.cull_mode = BaseMaterial3D.CULL_DISABLED
    mat.roughness = 0.9
    visual.material_override = mat
    body.add_child(visual)
    add_child(body)

func _setup_interaction_ui(layer: CanvasLayer) -> void:
    interact_button = Button.new()
    interact_button.text = "INTERACT"
    interact_button.visible = false
    interact_button.anchor_left = 1.0
    interact_button.anchor_right = 1.0
    interact_button.anchor_top = 1.0
    interact_button.anchor_bottom = 1.0
    interact_button.offset_left = -182.0
    interact_button.offset_right = -20.0
    interact_button.offset_top = -156.0
    interact_button.offset_bottom = -90.0
    interact_button.pressed.connect(_interact)
    layer.add_child(interact_button)
    feedback = Label.new()
    feedback.position = Vector2(22, 64)
    feedback.add_theme_font_size_override("font_size", 19)
    layer.add_child(feedback)

func _refresh_focus() -> void:
    var nearest: StaticBody3D = null
    var best := 2.4
    for item in targets:
        var d := player.global_position.distance_to(item.global_position)
        if d < best:
            best = d
            nearest = item
    focused = nearest
    interact_button.visible = focused != null and action_engine.phase == "idle"
    if focused != null:
        interact_button.text = "USE: " + focused.name

func _interact() -> void:
    if paused or focused == null or action_engine.phase != "idle":
        return
    if player.global_position.distance_to(focused.global_position) > 2.4:
        return
    action_engine.start_action(focused.name)

func _on_action_event(kind: String, target: String, seq: int) -> void:
    if kind == "started":
        feedback.text = "Using " + target + "..."
    elif kind == "completed":
        if not _save_world():
            push_warning("LifeSim local save failed")
        feedback.text = target + " completed (" + str(int(action_engine.counts.get(target, 0))) + ")"
    elif kind == "cancelled":
        feedback.text = target + " cancelled"
    print("LIFESIM_EVENT ", kind, " target=", target, " seq=", seq)

func _save_world() -> bool:
    return LifeSimSaveManager.write_world(action_engine.counts, player.global_position, yaw, pitch)

func _exit_tree() -> void:
    if action_engine != null and player != null and player.is_inside_tree():
        _save_world()

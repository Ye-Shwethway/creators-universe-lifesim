extends Node3D
var player: LifeSimPlayer
var cam: Camera3D
var yaw := 0.3
var pitch := -0.35
var paused := false

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
    var mesh := MeshInstance3D.new()
    var visual_mesh := CapsuleMesh.new()
    visual_mesh.height = 1.9
    mesh.mesh = visual_mesh
    mesh.position.y = 0.95
    body.add_child(mesh)
    player.add_child(body)
    add_child(player)
    cam = Camera3D.new()
    add_child(cam)
    cam.current = true
    var sun := DirectionalLight3D.new()
    sun.rotation_degrees = Vector3(-48, -35, 0)
    add_child(sun)
    var layer := CanvasLayer.new()
    add_child(layer)
    var hud := LifeSimMobileControls.new()
    layer.add_child(hud)
    hud.movement_changed.connect(func(a: Vector2) -> void: player.input_axis = a)
    hud.camera_dragged.connect(_orbit)
    hud.pause_toggled.connect(_pause)

func _physics_process(delta: float) -> void:
    if paused: return
    player.camera_yaw = yaw
    var focus := player.global_position + Vector3.UP * 1.2
    var ray := Vector3(sin(yaw)*cos(pitch), -sin(pitch), cos(yaw)*cos(pitch))
    cam.global_position = cam.global_position.lerp(focus + ray * 6.0, minf(1.0, delta * 9.0))
    cam.look_at(focus)

func _orbit(d: Vector2) -> void:
    yaw -= d.x * 0.006
    pitch = clampf(pitch - d.y * 0.004, -1.12, -0.12)

func _pause() -> void:
    paused = not paused
    player.set_physics_process(not paused)
    player.input_axis = Vector2.ZERO

func _build_room() -> void:
    # Light public procedural room perimeter; collision prevents leaving the platform.
    _box_prop(Vector3(0.0, 1.5, -7.0), Vector3(14.0, 3.0, 0.35), Color(0.30, 0.38, 0.44))
    _box_prop(Vector3(-7.0, 1.5, 0.0), Vector3(0.35, 3.0, 14.0), Color(0.30, 0.38, 0.44))
    _box_prop(Vector3(7.0, 1.5, 0.0), Vector3(0.35, 3.0, 14.0), Color(0.30, 0.38, 0.44))
    _box_prop(Vector3(0.0, 1.5, 7.0), Vector3(14.0, 3.0, 0.35), Color(0.30, 0.38, 0.44))
    # Simple furniture silhouettes, no third-party assets.
    _box_prop(Vector3(3.4, 0.4, -2.6), Vector3(2.2, 0.8, 1.0), Color(0.33, 0.53, 0.58))
    _box_prop(Vector3(-3.0, 0.45, -2.6), Vector3(1.6, 0.9, 0.8), Color(0.50, 0.38, 0.29))

func _box_prop(center: Vector3, size: Vector3, tint: Color) -> void:
    var body := StaticBody3D.new()
    body.position = center
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
    visual.material_override = mat
    body.add_child(visual)
    add_child(body)

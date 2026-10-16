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

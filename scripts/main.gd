extends Node3D
## Procedural placeholder scene; not yet a playable character controller.

func _ready() -> void:
    _create_world()

func _create_world() -> void:
    var floor_mesh := BoxMesh.new()
    floor_mesh.size = Vector3(14.0, 0.2, 14.0)
    var floor_node := MeshInstance3D.new()
    floor_node.mesh = floor_mesh
    floor_node.position = Vector3(0.0, -0.1, 0.0)
    add_child(floor_node)

    var actor := MeshInstance3D.new()
    var capsule := CapsuleMesh.new()
    capsule.radius = 0.35
    capsule.height = 1.9
    actor.mesh = capsule
    actor.position = Vector3(0.0, 1.0, 0.0)
    add_child(actor)

    var sun := DirectionalLight3D.new()
    sun.rotation_degrees = Vector3(-48.0, -35.0, 0.0)
    add_child(sun)

    var camera := Camera3D.new()
    camera.position = Vector3(3.5, 3.0, 6.0)
    camera.look_at(Vector3(0.0, 1.0, 0.0), Vector3.UP)
    camera.current = true
    add_child(camera)

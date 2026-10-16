extends Node3D
class_name ProceduralHumanoid
## Public geometry-only M1.3 visual bridge. NOT a MakeHuman mesh/rig.
var motion_time: float = 0.0
var left_arm: Node3D
var right_arm: Node3D
var left_leg: Node3D
var right_leg: Node3D

func _ready() -> void:
    _part("Torso", Vector3(0, 1.29, 0), Vector3(0.62, 0.75, 0.30), Color(0.20, 0.42, 0.64))
    _part("Hips", Vector3(0, 0.87, 0), Vector3(0.45, 0.28, 0.33), Color(0.13, 0.20, 0.29))
    _part("Neck", Vector3(0, 1.75, 0), Vector3(0.14, 0.17, 0.14), Color(0.75, 0.53, 0.37))
    _part("Head", Vector3(0, 1.96, 0), Vector3(0.33, 0.42, 0.33), Color(0.75, 0.53, 0.37), true)
    left_arm = _limb("LeftArm", Vector3(-0.43, 1.57, 0), Vector3(0, -0.34, 0), Vector3(0.21, 0.70, 0.22), Color(0.75, 0.53, 0.37))
    right_arm = _limb("RightArm", Vector3(0.43, 1.57, 0), Vector3(0, -0.34, 0), Vector3(0.21, 0.70, 0.22), Color(0.75, 0.53, 0.37))
    left_leg = _limb("LeftLeg", Vector3(-0.16, 0.77, 0), Vector3(0, -0.38, 0), Vector3(0.24, 0.77, 0.25), Color(0.17, 0.24, 0.33))
    right_leg = _limb("RightLeg", Vector3(0.16, 0.77, 0), Vector3(0, -0.38, 0), Vector3(0.24, 0.77, 0.25), Color(0.17, 0.24, 0.33))
    # Player movement uses local +Z as forward; shoe toes must project toward +Z.
    _part("LeftFoot", Vector3(-0.16, 0.09, 0.11), Vector3(0.26, 0.17, 0.45), Color(0.10, 0.13, 0.17))
    _part("RightFoot", Vector3(0.16, 0.09, 0.11), Vector3(0.26, 0.17, 0.45), Color(0.10, 0.13, 0.17))

func _part(label: String, at: Vector3, dimensions: Vector3, tint: Color, rounded: bool = false) -> void:
    var node := MeshInstance3D.new()
    node.name = label
    node.position = at
    if rounded:
        var sphere := SphereMesh.new()
        sphere.radius = 0.5
        sphere.height = 1.0
        node.mesh = sphere
        node.scale = dimensions
    else:
        var box := BoxMesh.new()
        box.size = dimensions
        node.mesh = box
    var mat := StandardMaterial3D.new()
    mat.albedo_color = tint
    mat.roughness = 0.9
    node.material_override = mat
    add_child(node)

func _limb(label: String, pivot: Vector3, offset: Vector3, dimensions: Vector3, tint: Color) -> Node3D:
    var joint := Node3D.new()
    joint.name = label
    joint.position = pivot
    add_child(joint)
    var piece := MeshInstance3D.new()
    piece.position = offset
    var box := BoxMesh.new()
    box.size = dimensions
    piece.mesh = box
    var mat := StandardMaterial3D.new()
    mat.albedo_color = tint
    piece.material_override = mat
    joint.add_child(piece)
    return joint

func update_locomotion(delta: float, horizontal_speed: float) -> void:
    var amount: float = clampf(horizontal_speed / 4.2, 0.0, 1.0)
    motion_time += delta * (7.0 + horizontal_speed)
    var wave: float = sin(motion_time) * 0.43 * amount
    left_leg.rotation.x = wave
    right_leg.rotation.x = -wave
    left_arm.rotation.x = -wave * 0.7
    right_arm.rotation.x = wave * 0.7

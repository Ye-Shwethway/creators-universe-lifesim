extends CharacterBody3D
class_name LifeSimPlayer

const WALK_SPEED: float = 4.2
const RUN_SPEED: float = 6.2
const ACCELERATION: float = 12.0
var input_axis: Vector2 = Vector2.ZERO
var running: bool = false
var camera_yaw: float = 0.0

func respawn() -> void:
    global_position = Vector3(0.0, 0.05, 0.0)
    velocity = Vector3.ZERO
    input_axis = Vector2.ZERO

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y -= 16.0 * delta
    elif velocity.y < 0.0:
        velocity.y = 0.0
    var kb: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    var axis: Vector2 = input_axis if input_axis.length_squared() > 0.01 else kb
    axis = axis.limit_length()
    var desired: Vector3 = Basis(Vector3.UP, camera_yaw) * Vector3(axis.x, 0.0, axis.y)
    var speed: float = RUN_SPEED if running or Input.is_action_pressed("sprint") else WALK_SPEED
    velocity.x = move_toward(velocity.x, desired.x * speed, ACCELERATION * delta)
    velocity.z = move_toward(velocity.z, desired.z * speed, ACCELERATION * delta)
    move_and_slide()
    if global_position.y < -4.0:
        respawn()
    global_position.x = clampf(global_position.x, -6.2, 6.2)
    global_position.z = clampf(global_position.z, -6.2, 6.2)
    if desired.length_squared() > 0.02:
        var target_angle: float = atan2(desired.x, desired.z)
        var visual: Node3D = get_node("Visual")
        visual.rotation.y = lerp_angle(visual.rotation.y, target_angle, minf(1.0, 9.0 * delta))

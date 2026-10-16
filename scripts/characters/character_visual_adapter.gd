extends Node3D
class_name LifeSimCharacterVisual
## Adapter between LifeSim movement and a future versioned, licensed rigged character.
## Missing/unapproved assets always fall back to original procedural humanoid.
const APPROVED_SCENE: String = "res://assets/public/approved/humanoid.glb"
const IDLE: String = "idle_in_place"
const WALK: String = "walk_in_place"
var fallback: ProceduralHumanoid
var rig_root: Node3D
var animator: AnimationPlayer
var active_motion: String = ""
var using_asset: bool = false

func _ready() -> void:
    fallback = ProceduralHumanoid.new()
    fallback.name = "ProceduralFallback"
    add_child(fallback)
    # Public generic test character; never load private Darian/canon assets.
    if not ResourceLoader.exists(APPROVED_SCENE):
        return
    var res: Resource = load(APPROVED_SCENE)
    if not (res is PackedScene):
        push_warning("LifeSim character asset is not a scene; keeping fallback")
        return
    var instance: Node = (res as PackedScene).instantiate()
    if not (instance is Node3D):
        instance.free()
        push_warning("LifeSim character scene has no Node3D root")
        return
    rig_root = instance as Node3D
    add_child(rig_root)
    animator = _find_animator(rig_root)
    if animator == null or not _has_motion(IDLE) or not _has_motion(WALK):
        rig_root.queue_free()
        rig_root = null
        animator = null
        push_warning("LifeSim character missing idle/walk; keeping fallback")
        return
    for motion in [IDLE, WALK]:
        var animation: Animation = animator.get_animation(_resolve_animation(motion))
        if animation != null:
            animation.loop_mode = Animation.LOOP_LINEAR
    fallback.hide()
    using_asset = true
    _switch_motion(IDLE)

func _find_animator(root: Node) -> AnimationPlayer:
    if root is AnimationPlayer:
        return root as AnimationPlayer
    for child in root.get_children():
        var match_node: AnimationPlayer = _find_animator(child)
        if match_node != null:
            return match_node
    return null

func _resolve_animation(name: String) -> String:
    if animator == null:
        return ""
    for key in animator.get_animation_list():
        if key == name or key.ends_with("/" + name):
            return key
    return ""

func _has_motion(name: String) -> bool:
    return _resolve_animation(name) != ""

func _switch_motion(name: String) -> void:
    if not using_asset:
        return
    var resolved: String = _resolve_animation(name)
    if resolved == "" or active_motion == resolved:
        return
    active_motion = resolved
    animator.play(resolved, 0.18)

func update_locomotion(delta: float, horizontal_speed: float) -> void:
    if not using_asset:
        fallback.update_locomotion(delta, horizontal_speed)
        return
    if horizontal_speed >= 0.2:
        _switch_motion(WALK)
    else:
        _switch_motion(IDLE)

func visual_mode() -> String:
    return "rigged" if using_asset else "procedural"

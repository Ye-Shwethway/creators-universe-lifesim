extends Node3D
class_name LifeSimCharacterVisual
## Adapter between LifeSim movement and a future versioned, licensed rigged character.
## Missing/unapproved assets always fall back to original procedural humanoid.
const APPROVED_SCENE: String = "res://assets/public/approved/humanoid.glb"
const IDLE: String = "idle_in_place"
const WALK: String = "walk_in_place"
const BATCH03_IDLE: String = "idle_relaxed"
const BATCH03_WALK: String = "walk_natural"
var selected_idle: String = IDLE
var selected_walk: String = WALK
var fallback: ProceduralHumanoid
var rig_root: Node3D
var animator: AnimationPlayer
var active_motion: String = ""
var using_asset: bool = false
var blend_tree: AnimationTree
var blend_space: AnimationNodeBlendSpace1D
var locomotion_blend: float = 0.0
const BLEND_REFERENCE_SPEED: float = 4.2 # Prototype input speed, not a measured gait speed.
const GAIT_METADATA_PATH: String = "res://assets/public/approved/gait_metadata.json"
var gait_reference_speed: float = 0.0
var gait_speed_verified: bool = false

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
    if animator != null and _has_motion(BATCH03_IDLE) and _has_motion(BATCH03_WALK):
        selected_idle = BATCH03_IDLE
        selected_walk = BATCH03_WALK
    if animator == null or not _has_motion(selected_idle) or not _has_motion(selected_walk):
        rig_root.queue_free()
        rig_root = null
        animator = null
        push_warning("LifeSim character missing idle/walk; keeping fallback")
        return
    for motion in [selected_idle, selected_walk]:
        var animation: Animation = animator.get_animation(_resolve_animation(motion))
        if animation != null:
            animation.loop_mode = Animation.LOOP_LINEAR
    # Imported GLB clips feed a speed-driven BlendSpace1D; physics retains movement ownership.
    blend_space = AnimationNodeBlendSpace1D.new()
    blend_space.min_space = 0.0
    blend_space.max_space = 1.0
    var idle_node := AnimationNodeAnimation.new()
    idle_node.animation = _resolve_animation(selected_idle)
    var walk_node := AnimationNodeAnimation.new()
    walk_node.animation = _resolve_animation(selected_walk)
    blend_space.add_blend_point(idle_node, 0.0)
    blend_space.add_blend_point(walk_node, 1.0)
    blend_tree = AnimationTree.new()
    blend_tree.name = "LocomotionTree"
    blend_tree.tree_root = blend_space
    add_child(blend_tree)
    blend_tree.anim_player = blend_tree.get_path_to(animator)
    blend_tree.active = true
    blend_tree.set("parameters/blend_position", 0.0)
    _load_gait_metadata()
    fallback.hide()
    using_asset = true
    active_motion = _resolve_animation(selected_idle)

func _load_gait_metadata() -> void:
    gait_reference_speed = 0.0
    gait_speed_verified = false
    if not FileAccess.file_exists(GAIT_METADATA_PATH):
        return
    var file := FileAccess.open(GAIT_METADATA_PATH, FileAccess.READ)
    if file == null:
        return
    var parsed: Variant = JSON.parse_string(file.get_as_text())
    if not (parsed is Dictionary):
        push_warning("Invalid gait metadata; retaining uncalibrated playback")
        return
    var data: Dictionary = parsed
    var stride: float = float(data.get("stride_length_m", 0.0))
    var cycle: float = float(data.get("cycle_duration_s", 0.0))
    if not bool(data.get("measured", false)) or stride <= 0.0 or cycle <= 0.0:
        return
    # Measured metadata must describe the actually imported walk clip.
    if String(data.get("animation_clip", "")) != selected_walk:
        push_warning("Gait metadata clip mismatch; refusing stride calibration")
        return
    gait_reference_speed = stride / cycle
    gait_speed_verified = gait_reference_speed > 0.0

func gait_debug() -> Dictionary:
    return {
        "mode": visual_mode(),
        "blend": locomotion_blend,
        "reference_speed": gait_reference_speed if gait_speed_verified else BLEND_REFERENCE_SPEED,
        "calibrated": gait_speed_verified,
        "animation": active_motion,
        "selected_walk": selected_walk
    }

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
    var target: float = clampf(horizontal_speed / BLEND_REFERENCE_SPEED, 0.0, 1.0)
    if gait_speed_verified:
        target = clampf(horizontal_speed / gait_reference_speed, 0.0, 1.0)
    locomotion_blend = move_toward(locomotion_blend, target, maxf(delta, 0.0) * 5.0)
    blend_tree.set("parameters/blend_position", locomotion_blend)
    # Only synchronize clip tempo when the asset producer supplied measured gait data.
    # 0.5x..2x avoids extreme poses; a metadata omission never fabricates stride.
    active_motion = _resolve_animation(selected_walk if locomotion_blend >= 0.5 else selected_idle)

func visual_mode() -> String:
    return "rigged" if using_asset else "procedural"

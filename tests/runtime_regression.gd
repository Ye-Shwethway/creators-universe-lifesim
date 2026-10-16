extends SceneTree
## CI-only headless regression: save sandbox, deterministic action transitions, visual fallback.
var failures: int = 0

func _assert(condition: bool, note: String) -> void:
    if condition:
        print("LIFESIM_QA_PASS ", note)
    else:
        failures += 1
        push_error("LIFESIM_QA_FAIL " + note)

func _initialize() -> void:
    call_deferred("_execute")

func _execute() -> void:
    var save_path: String = LifeSimSaveManager.SAVE_PATH
    # CI job uses a clean runner. Guard against accidental local/device execution.
    if OS.get_environment("GITHUB_ACTIONS") != "true":
        push_error("Runtime regression must run headless on a dedicated CI runner")
        quit(6)
        return
    var old_data: String = ""
    var had_file: bool = FileAccess.file_exists(save_path)
    if had_file:
        var old: FileAccess = FileAccess.open(save_path, FileAccess.READ)
        if old == null:
            quit(7)
            return
        old_data = old.get_as_text()
        old.close()
    var engine := LifeSimActionEngine.new()
    get_root().add_child(engine)
    var events: Array[String] = []
    engine.action_event.connect(func(kind: String, _target: String, _seq: int) -> void: events.append(kind))
    _assert(engine.start_action("Training Box"), "start action")
    _assert(not engine.start_action("Rest Bench"), "busy blocks second action")
    engine.advance(0.9)
    _assert(engine.phase == "active" and engine.progress() > 0.45, "partial tick")
    engine.advance(0.9)
    _assert(engine.phase == "idle" and engine.counts.get("Training Box", 0) == 1, "action completed exactly once")
    engine.advance(9.0)
    _assert(engine.counts.get("Training Box", 0) == 1 and events == ["started", "completed"], "completed action idempotent")
    _assert(engine.start_action("Rest Bench"), "second action starts")
    engine.cancel()
    _assert(engine.phase == "idle" and engine.counts.get("Rest Bench", 0) == 0 and events.back() == "cancelled", "cancel does not count")
    _assert(LifeSimSaveManager.write_world(engine.counts, Vector3(99.0, 0.05, -99.0), 0.3, -0.35), "save writes v1 world")
    var loaded: Dictionary = LifeSimSaveManager.read_world()
    _assert(not loaded.is_empty() and is_equal_approx(loaded["position"].x, 6.2) and is_equal_approx(loaded["position"].z, -6.2), "save position clamped")
    _assert(LifeSimSaveManager.read_counts().get("Training Box", -1) == 1, "save action counts roundtrip")
    var f: FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
    if f != null:
        f.store_string("{corrupt")
        f.close()
    _assert(LifeSimSaveManager.read_world().is_empty() and LifeSimSaveManager.read_counts().is_empty(), "corrupt save handled")
    var visual := LifeSimCharacterVisual.new()
    get_root().add_child(visual)
    await process_frame
    _assert(visual.visual_mode() == "procedural", "missing approved asset uses fallback")
    visual.update_locomotion(0.016, 3.0)
    _assert(visual.fallback != null and visual.fallback.visible, "fallback moves without animation asset")
    var left_shoe: MeshInstance3D = visual.fallback.get_node("LeftFoot") as MeshInstance3D
    var right_shoe: MeshInstance3D = visual.fallback.get_node("RightFoot") as MeshInstance3D
    _assert(left_shoe.position.z > 0.0 and right_shoe.position.z > 0.0, "procedural shoe toes align with local +Z forward")
    _assert(is_equal_approx(atan2(0.0, 1.0), 0.0), "controller +Z facing convention")
    var nav := LifeSimRoomPathfinder.new()
    _assert(not nav.route(Vector3.ZERO, Vector3(3.4, 0, -2.6)).size() > 0, "furniture destinations rejected")
    _assert(not nav.route(Vector3.ZERO, Vector3(7.5, 0, 0)).size() > 0, "off-map destinations rejected")
    _assert(nav.route(Vector3.ZERO, Vector3(4.5, 0, -4.5)).size() > 2, "route around furniture exists")
    visual.queue_free()
    engine.queue_free()
    # Preserve existing file if any, rather than leaving test save content behind.
    if had_file:
        var restore: FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
        if restore != null:
            restore.store_string(old_data)
            restore.close()
    else:
        DirAccess.remove_absolute(ProjectSettings.globalize_path(save_path))
    print("LIFESIM_QA_RESULT failures=", failures)
    quit(1 if failures > 0 else 0)

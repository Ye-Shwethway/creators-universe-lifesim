extends RefCounted
class_name LifeSimSaveManager

const SAVE_PATH: String = "user://lifesim_v1.json"
const SCHEMA_VERSION: int = 1
const TARGETS: Array[String] = ["Rest Bench", "Training Box"]

static func write_counts(counts: Dictionary) -> bool:
    var clean: Dictionary = {}
    for key in TARGETS:
        clean[key] = clampi(int(counts.get(key, 0)), 0, 1000000)
    var payload: Dictionary = {
        "schema_version": SCHEMA_VERSION,
        "action_counts": clean
    }
    var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file == null:
        push_warning("LifeSim save unavailable: " + str(FileAccess.get_open_error()))
        return false
    file.store_string(JSON.stringify(payload))
    file.close()
    return true

static func read_counts() -> Dictionary:
    if not FileAccess.file_exists(SAVE_PATH):
        return {}
    var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
    if file == null:
        return {}
    var parsed: Variant = JSON.parse_string(file.get_as_text())
    file.close()
    if typeof(parsed) != TYPE_DICTIONARY:
        return {}
    if int(parsed.get("schema_version", -1)) != SCHEMA_VERSION:
        return {}
    var values: Variant = parsed.get("action_counts", {})
    if typeof(values) != TYPE_DICTIONARY:
        return {}
    var safe: Dictionary = {}
    for key in TARGETS:
        var n: Variant = values.get(key, 0)
        if typeof(n) == TYPE_INT or typeof(n) == TYPE_FLOAT:
            safe[key] = clampi(int(n), 0, 1000000)
    return safe

extends RefCounted
class_name LifeSimSaveManager

const SAVE_PATH: String = "user://lifesim_v1.json"
const SCHEMA_VERSION: int = 1
const WORLD_KEY: String = "world"
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

# Backward-compatible: retain the v1 file and action_counts keys.
static func write_world(counts: Dictionary, position: Vector3, yaw: float, pitch: float) -> bool:
    var clean: Dictionary = {}
    for key in TARGETS:
        clean[key] = clampi(int(counts.get(key, 0)), 0, 1000000)
    var pos: Vector3 = Vector3(clampf(position.x, -6.2, 6.2), 0.05, clampf(position.z, -6.2, 6.2))
    var payload: Dictionary = {
        "schema_version": SCHEMA_VERSION,
        "action_counts": clean,
        WORLD_KEY: {"position": [pos.x, pos.y, pos.z], "yaw": wrapf(yaw, -PI, PI), "pitch": clampf(pitch, -1.12, -0.12)}
    }
    var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file == null:
        return false
    file.store_string(JSON.stringify(payload))
    file.close()
    return true

static func read_world() -> Dictionary:
    if not FileAccess.file_exists(SAVE_PATH):
        return {}
    var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
    if file == null:
        return {}
    var data: Variant = JSON.parse_string(file.get_as_text())
    file.close()
    if typeof(data) != TYPE_DICTIONARY or int(data.get("schema_version", -1)) != SCHEMA_VERSION:
        return {}
    var world: Variant = data.get(WORLD_KEY, {})
    if typeof(world) != TYPE_DICTIONARY:
        return {}
    var coords: Variant = world.get("position", [])
    if typeof(coords) != TYPE_ARRAY or coords.size() != 3:
        return {}
    for n in coords:
        if not (typeof(n) == TYPE_INT or typeof(n) == TYPE_FLOAT) or not is_finite(float(n)):
            return {}
    var x: float = float(coords[0])
    var z: float = float(coords[2])
    var y: Variant = world.get("yaw", 0.3)
    var p: Variant = world.get("pitch", -0.35)
    if not (typeof(y) in [TYPE_INT, TYPE_FLOAT]) or not (typeof(p) in [TYPE_INT, TYPE_FLOAT]):
        return {}
    if not is_finite(float(y)) or not is_finite(float(p)):
        return {}
    return {"position": Vector3(clampf(x, -6.2, 6.2), 0.05, clampf(z, -6.2, 6.2)), "yaw": wrapf(float(y), -PI, PI), "pitch": clampf(float(p), -1.12, -0.12)}

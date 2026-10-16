extends Node
class_name LifeSimActionEngine
signal action_event(kind: String, target: String, sequence: int)

var phase: String = "idle"
var target_name: String = ""
var elapsed: float = 0.0
var duration: float = 1.8
var sequence: int = 0
var counts: Dictionary = {}

func start_action(name: String) -> bool:
    if phase != "idle" or name.is_empty():
        return false
    target_name = name
    elapsed = 0.0
    phase = "active"
    sequence += 1
    action_event.emit("started", target_name, sequence)
    return true

func advance(delta: float) -> void:
    if phase != "active":
        return
    elapsed += maxf(delta, 0.0)
    if elapsed >= duration:
        phase = "idle"
        counts[target_name] = int(counts.get(target_name, 0)) + 1
        action_event.emit("completed", target_name, sequence)
        target_name = ""
        elapsed = 0.0

func cancel() -> void:
    if phase != "active":
        return
    var interrupted := target_name
    phase = "idle"
    target_name = ""
    elapsed = 0.0
    action_event.emit("cancelled", interrupted, sequence)

func progress() -> float:
    if phase != "active":
        return 0.0
    return clampf(elapsed / duration, 0.0, 1.0)

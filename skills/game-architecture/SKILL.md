# game-architecture

**Scope:** State owner separation; scene composition; event/tick contracts; decisions.

## Instructions
Design bounded modular simulation where Godot scenes are presentation and authoritative state is in dedicated versioned data objects. Define input-to-action-to-tick-to-event ordering, pause/speed, idempotency and save barriers. Prefer signals for view events, direct calls for core business invariants. Prevent NPC code from mutating unrelated state.

## Mandatory verification
Require module responsibility table, sequence diagram in text, deterministic tests for ordering and reload; show state/schema migration impact.

## References
- https://docs.godotengine.org/en/stable/getting_started/step_by_step/scene_tree.html

## Execution note
Load this file only when selected by `skills/registry.yaml`. Record actual source read, implementation evidence and outstanding failures in a task receipt. Never assert runtime performance or feature completion without direct evidence.

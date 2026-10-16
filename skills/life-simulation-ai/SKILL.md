# life-simulation-ai

**Scope:** Simulation time/needs/training/NPC policy/relationships/memory.

## Instructions
Fixed-step deterministic authoritative simulation with bounded decisions. Behavior arbitration prioritizes immediate needs, explicit orders, schedules and interruptions. Fitness progression is delayed and bounded by recovery/training/nutrition. World states persisted as schema-versioned saves; LLM optional nonauthoritative helper only.

## Mandatory verification
Reproducible scenario tests: pause/resume, fast-forward, NPC conflicting goals, no double actions, save-load equivalence, training ceilings, mode switching.

## References
- https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html

## Execution note
Load this file only when selected by `skills/registry.yaml`. Record actual source read, implementation evidence and outstanding failures in a task receipt. Never assert runtime performance or feature completion without direct evidence.

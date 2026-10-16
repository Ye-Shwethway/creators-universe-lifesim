# ADR-0002 — Deterministic Life Simulation
Status: proposed design gate
Date: 2026-10-16

## State ownership
SimulationState owns world_time, entity records, needs, relationships, action queues and events. UI/3D nodes can observe but may not directly mutate authoritative state. Commands validate preconditions, then update via fixed tick. Renderer consumes snapshots, interpolates presentation only.

## Tick ordering
1. Drain stamped player/autonomy commands.
2. Validate mode precedence and entity preconditions.
3. Resolve exclusive resources (room, equipment, NPC attention).
4. Advance clock and needs in deterministic order.
5. Execute action progression/recovery/training adaptation.
6. Write ordered events and commit save-safe state snapshot.
7. Publish immutable view snapshot, renderer interpolates between ticks.

One character action occupies a slot. Idempotency key prevents repeated application. Pause means no simulated time; speed-up runs bounded ticks. Background browser tabs may throttle; resume uses explicit policy, not wall-clock conflation. Randomness uses persisted seed for replayable scenarios.

## Modes
Direct: user movement/input wins within valid world rules.
Guided: user queues intents; NPC/character policy fills idle gaps.
Autonomous: needs/schedule planner chooses candidate actions.
Mode transition cancels or preserves queued commands according to explicit player choice; never silently clears long-running interaction.

## Persistence
Versioned JSON-like game save with schema_version, committed_tick, seed, world state and checksum/integrity guard. Atomic save where feasible; migration tested before replacing current save.

## Tests
Repeat identical seed/commands → identical state/events; save-load round trip; conflicting gym usage; sleep + time acceleration; pause; autonomous/manual collision; double-event regression; bounded training adaptation.

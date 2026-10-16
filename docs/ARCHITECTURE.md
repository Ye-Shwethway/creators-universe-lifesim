# Architecture — v0.1 Proposed Baseline

## Principles
- Godot 4 GDScript for both Web and Android, no Flutter/JS rendering bridge.
- Simulation logic is decoupled from visual presentation and ticked on a controlled schedule.
- Mode: Direct (manual movement), Guided (player queues commands), Autonomous (needs-based policy). Same world-state machine.
- Canonical game state stored locally in schema-versioned saves; avoid runtime dependency on LLM or network.
- Visual body customization uses a rigged mesh + authored blend shapes/morph targets after asset validation; numerical measurement changes are NOT sufficient for real anatomy.
- Growth modeled from training load, time, recovery, diet and caps; no instant unrealistic hypertrophy on every click.
- Browser export uses Godot Compatibility/WebGL2 constraints; Android native renderer is validated separately.
- Keep physics/navigation/animation rates and quality adaptive to phone performance.

## Code ownership
scenes/ = nodes, cameras, game levels and presentation.
scripts/simulation/ = game clock, needs, routines, relationships, training policies.
scripts/characters/ = customization, visual parameter adapter.
scripts/control/ = hybrid control and input.
scripts/persistence/ = save/load and migrations.
assets/public/ = redistributable approved placeholder art and metadata.
assets/private/ = forbidden Git commit path; use private storage and controlled packaging.
tests/ = deterministic headless gameplay tests.
docs/ = decisions, changelog and work continuity.

## Milestone boundaries
M0: valid repository, Godot project, editor/headless parsing, build workflows.
M1: controllable generic avatar in a single low-poly room, touch camera/joystick, Web+APK verified.
M2: data-driven character editor and working deformable rig.
M3: clock, needs, training, save/load and deterministic tests.
M4: NPC routine, relationship state and autonomous actions.
No asset/private canon publication implied by technical milestones.

# Implementation Roadmap — evidence-based
Updated: 2026-10-16
Statuses: PLANNED → IN_PROGRESS → CODE_COMPLETE → CI_VERIFIED → DEVICE_VERIFIED → CREATOR_APPROVED → CLOSED. An individual artifact may be CI_VERIFIED while a slice remains open. No automatic promotion.

## M0 — Foundation (CI and Web runtime demonstrated; not fully closed)
- [x] Godot 4.7.2 GDScript project, domain skills, agent bootstrap, privacy boundary
- [x] GitHub Actions headless validation: run 38855603349
- [x] Web export: run 38855603531
- [x] Android debug artifact: run 38856054864 (installation NOT demonstrated)
- [x] Cloudflare Pages deployment: run 38857984698 and domain active
- [x] User-provided Redmi K70 screenshot shows rendered Web 3D floor, capsule, camera on lifesim.drthorne.uk
- [ ] Android debug APK installation/launch on physical device
- [ ] Baseline browser console and runtime/performance diagnostics (not inferred from screenshot)

## M1 — Mobile Playable Prototype
### M1.1 — Mobile controls + viewport [DEVICE VERIFIED; NONBLOCKING UI REFINEMENTS REMAIN]
Dependencies: M0 web runtime demonstrated; primary skill game-ui-ux; supporting godot-engineering, mobile-3d-rendering, game-quality-assurance.
Scope:
- [x] Separate CharacterBody3D controller, collision floor and capsule proxy; WASD/keyboard fallback (CI verified)
- [x] Initial touch joystick/HUD and camera drag input implemented (phone usability not yet verified)
- [ ] Orbit pitch constrained; distance and collision avoidance/reset controls still need refinement
- [ ] Pause toggle and help hints implemented; settings and physical-device usability pending
- [ ] Orientation behavior documented: responsive portrait fallback vs landscape intended mode (avoid inaccessible screen)
- [x] Procedural placeholder only; no third-party character assets added
Acceptance: no GDScript parse errors; deterministic controller unit/smoke where possible; successful Web+APK build; no private assets; Creator on-phone reports joystick/camera usable, layout legible. Record FPS observation separately; not necessary to fabricate performance metrics.
Deliverable: versioned Web deploy + APK artifact, screenshots/device feedback. Do not mark CLOSED from CI alone.

### M1.2 — Interactive mini-environment [ROOM/COLLISIONS DEVICE VERIFIED; INTERACTION MECHANICS PENDING]
Depends on M1.1 usability.
- [ ] One low-poly room, walls and stable physics/collision
- [ ] Simple furniture/prop geometry; proximity interaction focus and interact action
- [ ] Minimal interaction state/event hook to future simulation core
- [ ] Collision and camera obstruction regression checks
Acceptance: phone Web + Android checks; interactions activate exactly once; frame stability measured.

### M1.3 — Generic humanoid/character pipeline [PLANNED]
Depends on M1.1 and license/rig gate.
- [ ] Compare MakeHuman→Blender→GLB with independently authored/blend shape meshes
- [ ] Source/license/hash evidence and publicly redistributable generic model
- [ ] Skeleton3D, idle/walk/turn clips, AnimationTree; morph stress tests
- [ ] Mobile render optimization and measurement-to-visual mapping feasibility
Acceptance: GLB import, actual shape keys verified, motion deformation QA, public asset manifest and device benchmark. Never publish private Darian reference media.

### M1.4 — Release/performance hardening [PLANNED]
- [ ] FPS/frame-time, memory, orientation and input evaluation on Redmi K70 Chrome
- [ ] Android debug APK install/launch and input parity
- [ ] Cloudflare Pages WASM chunk streaming route regression and cache behavior
- [ ] Quality settings, loading/error fallback, durable build evidence
Acceptance: all applicable V01-V12 checks satisfied or explicitly deferred with Creator approval.

### M1.1 implementation evidence (2026-10-16)
- Godot validation: https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38858928498 (success)
- Android debug: https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38858830484 (success)
- Web export: https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38858928342 (success)
- Pages deployment: https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38859007168 (success)
- Cloudflare latest production deployment 9819ff7e-2e51-4772-867b-8f6aaa536056 (success), source SHA 32a9193fcb66b330b9745c309e0caa6ff585a9a3.
- Device joystick/camera functionality and APK installation are NOT verified. Slice remains open pending real-device feedback.

## Delivery policy — Creator decision (2026-10-16)
Development is **Web-first**. Run Godot validation, Web export and Cloudflare deploy for routine slices; Android APK is **manual workflow_dispatch only** and should not be built for every slice. Existing Android workflow is preserved as a future compatibility gate. Device test evidence: Creator confirms touch movement and camera working on Redmi K70, but walked off platform and fell, unable to recover. A floor-boundary clamp and fall respawn fix plus simple wall/furniture collisions are committed; phone recheck pending. Work on M1.2 interaction and camera collision continues after web smoke verification.

## M2 — Character Lab [PLANNED]
Rigged customization, blend shapes, imperial measurements, safe interpolation, character profile saves and private identity review.

## M3 — Living Simulation [PLANNED]
Deterministic clock, needs, fitness adaptation, recovery/nutrition, save migrations, action priorities.

## M4 — Autonomous Life [PLANNED]
NPC schedules, conflicts, relationships, Direct/Guided/Autonomous modes, persistent event history.

## Milestone sync contract
Every implementation slice must end with source commit SHA, selected skills, changed files, tests and Actions run URLs, Web deploy ID where applicable, device evidence, asset/privacy outcome, unresolved issues, and explicit status. In SAME completion pass, reconcile docs/ROADMAP.md, docs/CURRENT_STATE.md, docs/VALIDATION_MATRIX.md, and any relevant ADR / skill / deployment docs; read-back all updated files. If any write fails, slice remains OPEN and the mismatch must be reported; never claim cross-file sync without remote read-back. Update new-chat bootstrap when entrypoints or handoff rules change. Prior historical checkpoint entries may remain as history, but current state must clearly supersede them.

### M1.2 Web-first evidence — 2026-10-16
- Character fall recovery and x/z world bounds, four solid room walls and two procedural furniture boxes committed.
- Godot validation [38859675610](https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38859675610) SUCCESS.
- Web build [38859675605](https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38859675605) SUCCESS.
- Cloudflare deployment `dcaf0886-cec5-4db4-a74a-9879c3da4d4c` SUCCESS from SHA `18a5eda9204ce379d250834dd8ceb6db4679dfb6`.
- M1.2 still IN PROGRESS: interactive object prompts/events and Creator phone fall-recovery recheck pending. Android remains manual-only.

### Redmi K70 Creator QA — 2026-10-16
Creator provided three landscape screenshots showing the bounded room, objects, joystick and multiple orbit views; reports no more floor falls and successful object contact/collision. These specific visual, boundary and collision checks are DEVICE_VERIFIED. Interaction button, proximity prompt and game-state event hooks are not implemented/tested and M1.2 remains OPEN. Android APK stays manual-only.

### M1.2 interaction slice — 2026-10-16
- [x] Proximity selection of Rest Bench and Training Box (distance threshold 2.4 world units), touch-accessible contextual USE button and on-screen usage counter. Event output is an initial console event hook, not yet a persistent simulation event bus.
- Godot validation [38860662402](https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38860662402): SUCCESS.
- Cloudflare Pages deployment [38860715373](https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38860715373): SUCCESS; deployment `25c4981a-8a3d-4a29-a952-ec1cad65ab92`, source `d28755d0b81846ac2e11101d141520dee9f17c61`.
- Interactive behavior is deployed but **Creator phone gesture/tap verification remains pending**. M1.2 stays OPEN; no APK build triggered (manual-only policy).

### M1.2 Creator interaction confirmation + action lifecycle (2026-10-16)
- Creator screenshot shows `Training Box used 1 time(s)` after tapping contextual USE; touch interaction verified on Redmi K70.
- Timed reusable action engine added with idle/active, start/complete/cancel signals, per-object count and one-action-at-a-time guard; Godot headless validate run 38861694481 SUCCESS.
- New action lifecycle is code/CI verified, not yet device verified. Game state is session-only; persistence and robust event ownership remain future work. M1.2 remains OPEN pending new Web deploy and mobile validation.
- APK manual-only; Web-first development continues.

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
### M1.1 — Mobile controls + viewport [PLANNED; implement next]
Dependencies: M0 web runtime demonstrated; primary skill game-ui-ux; supporting godot-engineering, mobile-3d-rendering, game-quality-assurance.
Scope:
- [ ] Separate CharacterBody3D controller, collision floor and capsule proxy; WASD/keyboard fallback
- [ ] Mobile landscape-friendly HUD and responsive anchors; joystick movement and second-area touch camera orbit
- [ ] Orbit distance/pitch bounds; camera collision or obstruction strategy; reset camera button
- [ ] Pause/settings and readable interaction hints; explicit controls for mobile touch
- [ ] Orientation behavior documented: responsive portrait fallback vs landscape intended mode (avoid inaccessible screen)
- [ ] No private character assets
Acceptance: no GDScript parse errors; deterministic controller unit/smoke where possible; successful Web+APK build; no private assets; Creator on-phone reports joystick/camera usable, layout legible. Record FPS observation separately; not necessary to fabricate performance metrics.
Deliverable: versioned Web deploy + APK artifact, screenshots/device feedback. Do not mark CLOSED from CI alone.

### M1.2 — Interactive mini-environment [PLANNED]
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

## M2 — Character Lab [PLANNED]
Rigged customization, blend shapes, imperial measurements, safe interpolation, character profile saves and private identity review.

## M3 — Living Simulation [PLANNED]
Deterministic clock, needs, fitness adaptation, recovery/nutrition, save migrations, action priorities.

## M4 — Autonomous Life [PLANNED]
NPC schedules, conflicts, relationships, Direct/Guided/Autonomous modes, persistent event history.

## Milestone sync contract
Every implementation slice must end with source commit SHA, selected skills, changed files, tests and Actions run URLs, Web deploy ID where applicable, device evidence, asset/privacy outcome, unresolved issues, and explicit status. In SAME completion pass, reconcile docs/ROADMAP.md, docs/CURRENT_STATE.md, docs/VALIDATION_MATRIX.md, and any relevant ADR / skill / deployment docs; read-back all updated files. If any write fails, slice remains OPEN and the mismatch must be reported; never claim cross-file sync without remote read-back. Update new-chat bootstrap when entrypoints or handoff rules change. Prior historical checkpoint entries may remain as history, but current state must clearly supersede them.

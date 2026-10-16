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

## Timed-action Web deployment — 2026-10-16
Cloudflare production deployment 76930774-8bc2-4b72-a83f-207a89dd646c SUCCESS for code commit 44699162a130e2e7d7b69d143809ff39c31095de; headless validation 38861694481 SUCCESS. This is a new version of the interaction logic. The prior Creator phone screenshot verifies the former immediate-counter interaction, not the new timed completion. Phone validation of the 1.8-second action lifecycle remains open. APK build remains manual-only.

### Local save prototype 2026-10-16
Added `scripts/persistence/save_manager.gd` schema v1 allowlisted interaction counts. Loads at startup and writes after completed actions. Godot validation 38862100255 SUCCESS; Pages deploy 38862189075 SUCCESS. Browser-refresh retention, migration and corruption tests pending; M3 persistence not closed. APK manual-only.

### Creator browser persistence QA — 2026-10-16
- [x] Redmi K70 browser session test: completed Training Box three times, exited/reopened game, completed once more, and UI displayed `Training Box completed (4)`; Creator screenshot supplied. Basic completed-action usage-counter persistence is DEVICE VERIFIED.
- Full world-state persistence, migration, corruption recovery and quota eviction remain NOT verified; M3 save system not closed. Browser site-data deletion/private browsing may remove local save.

### World pose save extension — 2026-10-16
- Implemented v1 backward-compatible `world` field storing bounded player location and orbit yaw/pitch, retaining existing action_counts; automatic save every 3 seconds and on interaction completion/scene exit. Old count-only files remain readable.
- Godot validation run 38862774933 SUCCESS. Web production deploy latest code still pending confirmation. Device test for restore of position/camera pending. This is partial persistence, not full M3 closure. APK remains manual-only.

## World pose save deployment verified — 2026-10-16
Godot validate run 38862774933 SUCCESS. Cloudflare deploy run 38862907783 SUCCESS, Cloudflare deployment 81cbaf4a-23d5-4a34-a58c-139554497bd3 production/success at commit 9f8caa8bfa5ab1ff9918e327c4602d96218f18f2. Position/camera restore across reload is NOT phone-verified; old count-only save compatibility implemented but not regression-tested on physical device. APK manual-only.

### Redmi K70 position restore verification — 2026-10-16
Creator exited/reopened LifeSim and confirmed player resumed at the previous room location. Screenshot also shows `Training Box completed (5)`. Character position restore and usage-count continuity are DEVICE_VERIFIED. Camera yaw/pitch restoration is not independently confirmed from this screenshot. Full saves and migration remain open.

### Camera obstruction refinement — 2026-10-16
Creator verified avatar location restores across browser revisit and observed Training Box completed (5); camera rotation restore has not been independently tested. Implemented physics raycast camera occlusion adjustment for walls, with fast inward reposition. Godot validation run 38863320136 SUCCESS; Web deploy run 38863369314 dispatched. Mobile camera-collision check pending. APK manual-only.

## Camera Web deploy verification — 2026-10-16
GitHub deploy run 38863369314 completed SUCCESS; Cloudflare production deployment ad4bcb3b-fbc2-49fc-8ecb-776c73900275 SUCCESS for source SHA 6af231af4cfb8157c7f6b38ee476cb43b4b1c070. Camera occlusion correction is deployed, not yet Redmi K70 verified. APK intentionally not built.

### M1.3 visible humanoid bridge — 2026-10-16
- Creator feedback: camera movement improved; two walls appear black/unlit, requests a recognizable human character. This is visual feedback, not performance certification.
- Added source-authored procedural humanoid with head/torso/arms/legs and basic alternating limb swing; replaced capsule mesh visual without changing existing CharacterBody3D collision, interactions or local saves.
- Improved ambient illumination and made procedural wall materials two-sided to mitigate back-face darkness. Does not yet establish correct physical lighting across all views.
- Godot validate run 38865092817 SUCCESS. Cloudflare deploy run 38865152354 dispatched; runtime visual/device verification pending.
- M1.3 remains IN PROGRESS. This is NOT a rigged MakeHuman character and has no authored physique morph targets; MakeHuman/Blender/GLB licensing and rigging acceptance gates still open. Android build manual-only.

## M1.3 Web deployment confirmed — 2026-10-16
Godot validate 38865092817 SUCCESS; Cloudflare deploy workflow 38865152354 production release succeeded; Cloudflare deployment 1802de7e-19c0-47cf-b49b-3e63a16cfe66 SUCCESS from source commit 2726fa3545a7140718cfa7c1717d97fba8300af2. New procedural humanoid is NOT MakeHuman, and phone runtime render/lighting changes are not yet verified. Keep M1.3 OPEN, APK manual-only.

### M1.3 Creator visual QA — 2026-10-16
Creator screenshot on Redmi K70 confirms procedural humanoid visually present and wall surfaces no longer fully black. Basic visual rendering and lighting improvement DEVICE_VERIFIED. Mesh is still procedural and not MakeHuman/rigged; animation motion/FPS not measured. Next focus real generic rigged humanoid asset sourcing/import validation.

### M1.3 Asset pipeline acceptance tooling — 2026-10-16
Added tools/audit_gltf.py, tests/test_gltf_audit.py and asset-audit workflow. This program checks GLB/glTF metadata (skin connections, joint counts, animations, morph targets); synthetic format unit tests and audit job steps succeeded in GitHub run 38866465959. **No actual MakeHuman/MPFB model was generated or imported**. Next: reproduce CC0 MPFB GameEngine rig/material, GLB export and actual Godot render. Do not promote M1.3 to closed. Web-first, APK manual-only.

### M1.3 actual MakeHuman-derived GLB experiment — 2026-10-16
Sourced a candidate CC0-derived parametric humanoid GLB from nirholas/three.ws (52-bone / 122 morphs per vendor description). Download and metadata audit passed in isolated GitHub workflow run 38866915144, but Godot importer emitted many `Sparse indices buffer view size did not exactly match the expected size` errors while job incorrectly returned success. This candidate is NOT production-approved. Updated `.github/workflows/evaluate-humanoid.yml` to fail on Godot import errors and re-ran 38867034279. Existing procedural humanoid stays live; real asset import gate remains OPEN. No APK triggered.

## Strict import gate result — 2026-10-16
GitHub Actions https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38867034279 concluded FAILURE as designed, at Godot GLB importer smoke step, following sparse accessor errors. This confirms candidate cannot be accepted unchanged. No production asset/deploy change; live procedural humanoid unaffected. Next experiment: re-export with dense accessors in Blender/gltf-transform or test alternate CC0 GLB, then rerun strict import.

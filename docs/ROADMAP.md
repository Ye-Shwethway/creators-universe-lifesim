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

### M1.2b — Tap-to-Move and hybrid navigation [PLANNED — NEXT GAMEPLAY PRIORITY]
Creator request 2026-10-16: retain mobile joystick AND add tap-on-ground destination targeting, intended for future large worlds. This was not explicitly scheduled in the previous roadmap.
- [ ] Ground hit-test via camera ray on valid navigable surfaces; show a visible target marker and clear it on arrival/cancel.
- [ ] NavigationRegion3D/NavigationMesh plus NavigationAgent3D pathfinding around walls and furniture; handle invalid, unreachable and off-map taps safely.
- [ ] Hybrid control priority: any joystick/keyboard movement cancels auto-walk immediately; camera orbit touch must not set destinations, and UI interactions must not leak taps into navigation.
- [ ] Path following respects current CharacterBody3D collisions/turning, does not teleport, and reuses the visual adapter idle/walk interface.
- [ ] Initially support current room; later handle multi-region maps, dynamic obstacles, and object interaction approach positions (follow-up, not falsely claimed complete).
- [ ] Deterministic headless tests for navigation target selection/cancellation/reachability plus Web runtime CI and Creator Redmi K70 tap-versus-drag test.
Dependencies: current M1.2 room collisions and M1.1 touch controls; independent of Orison batch-02 GLB. Web-first; manual APK only.
Acceptance: tap walk reaches reachable marked point without crossing walls/furniture, joystick instantly overrides, camera orbit continues to work, no input leakage from HUD, device verification and browser performance recorded.

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

### M1.3 sparse accessor recovery — 2026-10-16
- Blender roundtrip now reconstructs candidate GLB in isolated GitHub CI, preserving reported rig and >=4 morph targets; strict Godot import passed without logged importer errors. Workflow run 38867423771 SUCCESS.
- Original GLB was rejected; normalized output remains CI temporary and is NOT committed/deployed. Actual rig deformations, independent named physique morphs, source asset legal provenance and on-phone rendering remain to be verified before replacing procedural character. M1.3 OPEN; APK manual-only.

### M1.3 instantiated GLB gate — 2026-10-16
Added tools/inspect_humanoid.gd to instantiate normalized candidate as a PackedScene in Godot and enumerate actual Skeleton3D nodes/bone counts, MeshInstance3D blend shapes and AnimationPlayer clips; acceptance script rejects absent rigs and <4 shape keys. Updated isolated evaluate-humanoid workflow to run the check. Run 38868131012 dispatched and awaiting result at checkpoint. No model deployed. Web-first/APK manual-only.

## Instantiated Godot humanoid gate VERIFIED — 2026-10-16
Run https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38868131012 completed SUCCESS. Godot scene actually loaded/instantiated after Blender normalization, runtime stdout: `LIFESIM_HUMANOID_INSPECT skeletons=1 bones=52 mesh_nodes=4 shape_keys=395 clips=0`. These are summed shape keys across mesh instances, not 395 unique editable body attributes. Thus structural rig/shape imports PASS; **zero imported animation clips**, and individual physique controls/body deformation, legal redistribution, and mobile Web performance remain UNVERIFIED. Candidate still only in isolated CI, not shipped. Next: animation retarget/author idle-walk and pose/morph semantic audit; preserve existing visual until gates passed. APK manual-only.

### M1.3 rig/physique semantics — 2026-10-16
Isolated normalized candidate's imported Godot scene showed mixamorig skeleton bones and named morphs including shouldersWider, chestPectorals, waistNarrower, armsMuscular, bodyMuscular (run 38868803605 SUCCESS). Added true runtime bone pose rotation + morph assignment/readback gate in tools/inspect_humanoid.gd; run 38869052568 underway. This is structural control testing, NOT proof of natural deformation, visuals, licensing, 0 animation clips or production readiness. Procedural humanoid remains live, APK manual-only.

## M1.3 real Godot pose/morph assignment gate — 2026-10-16
CI run 38869052568 SUCCESS, runtime output `LIFESIM_HUMANOID_INSPECT skeletons=1 bones=52 mesh_nodes=4 shape_keys=395 clips=0` and `LIFESIM_POSE_MORPH_TEST bones=4 morph_assignments=5 PASS`. Verified four mixamorig limb bones accept pose rotations and five named physique blend shapes (shouldersWider, chestPectorals, waistNarrower, armsMuscular, bodyMuscular) accept/get 0.5 values on imported MeshInstance3D. This proves runtime setters, NOT realistic visual deformation or animation playback; 0 animation clips, license clearance and Web device acceptance still open. Candidate isolated in CI, live procedural humanoid remains. Web-first, APK manual-only.

### M1.3 isolated visual QA pipeline — 2026-10-16
Committed `tools/render_humanoid.py` and extended `evaluate-humanoid.yml`: after normalized GLB rig/morph import, Blender generates neutral, shouldersWider, chestPectorals, armsMuscular comparison PNGs in temporary CI; artifacts retained two days for manual review. Run 38869523580 triggered, result not yet verified at checkpoint. No model assets added to public repo/build. Visual comparison and license clearance still pending; existing procedural avatar stays live, APK manual-only.

## M1.3 actual visual QA result — 2026-10-16
GitHub Actions run 38869748123 SUCCESS after adding Xvfb/Mesa (prior run 38869523580 failed `Unable to open a display`). Workflow produced neutral, shouldersWider, chestPectorals, armsMuscular PNGs; artifact `humanoid-visual-qa` ID 12033236185. Downloaded and visually inspected all four images. Full human mesh is visible, but **skin highlights are heavily overexposed and morph differences are not convincingly legible** at current camera/lighting; therefore qualitative deformation/appearance gate remains OPEN. This is a visualization/test setup problem needing controlled illumination plus geometric delta measurements, not evidence that mesh/morph quality is acceptable. Candidate not published, asset/license clearance pending; no APK built.

### M1.3 game-side character adapter — 2026-10-16
- Added `LifeSimCharacterVisual` adapter to isolate model/idle-walk animation playback from movement physics and persistence; approved assets loaded only from `res://assets/public/approved/humanoid.tscn`. Unavailable scene/animations fall back to existing procedural humanoid, without modifying Orison batch-01 or publicizing private images.
- Wired `scripts/main.gd` through adapter. Godot validation run 38872498839 SUCCESS; Web deploy/device visual gate pending. Orison batch-02 assets and provenance not yet accepted. APK manual-only.

## M1.3 character adapter production deployment — 2026-10-16
Godot validate run 38872498839 SUCCESS; Web deploy run 38872624167 SUCCESS; Cloudflare deployment 25442735-503c-4a4f-b756-f52b291d9bdb status success at commit 378e2733bcf88c82520c35552468587f4f7e32d3. `LifeSimCharacterVisual` safely retains procedural humanoid until an approved scene and idle/walk clips exist. No Orison model in public build, no APK build. Redmi K70 adapter regression not yet device-verified.

## Engine regression + private Access device checkpoint — 2026-10-16
Creator confirmed Cloudflare owner-only email OTP login works on phone (manual device evidence for login flow only, not exhaustive bypass penetration test). Added CI-only `tests/runtime_regression.gd` and CI execution in `.github/workflows/validate.yml`: verifies action busy/idempotent/cancel transitions, v1 count/world save roundtrip, position clamping, corrupt JSON fallback, no-approved-asset procedural character fallback. Initial CI run 38874299156 failed due an incorrect headless-feature guard, and startup logs exposed `_exit_tree` reading a detached player. Fixed CI guard via `GITHUB_ACTIONS` and added player.is_inside_tree() shutdown guard; rerun 38874462587 SUCCESS with 13 LIFESIM_QA_PASS and failures=0. Invalid JSON probe causes expected Godot parser ERROR log lines; assertions passed. Web workflow 38874646788 SUCCESS, Cloudflare deployment 978f05aa-afd9-43fd-aaf2-9522e28b96da success for commit 926f0d00ee3c8e1fb62a5cc7f6c9979e196cb22e. Tests executed only in CI, no gameplay device retest of updated build; APK not run, no Orison asset published. M1.3 character visuals remain pending on Orison batch-02.

## M1.3 procedural facing correction — 2026-10-16
Creator reported player appearing to walk backwards. Inspected actual source: controller faces local +Z via atan2(desired.x,desired.z), while procedural shoe front offsets were local -Z. Changed left/right shoe offsets to +0.11 local Z, preserving movement, camera, save and future rig adapter. Extended CI runtime regression with shoe-forward and controller-forward checks. Validate run 38875577208 SUCCESS. Web deploy run 38875645418 SUCCESS, CF deployment 19575fa9-0f79-4ef2-aaff-a08cd055c53f success for commit 328e9143edfa0cff7512aaab87bd8e28fa553d5c. Device visual confirmation pending; not yet proving natural animation (swing primitive). Private Access unchanged. No Orison assets uploaded, APK manual-only.

## M1.2b current-room Tap-to-Move slice — 2026-10-16
Implemented `LifeSimRoomPathfinder` clearance-aware AStarGrid2D for current 14×14 room with furniture exclusion; `LifeSimMobileControls` distinguishes right-side taps from camera drags and preserves left joystick; `scripts/main.gd` adds target disc, 3D ray-plane targeting, auto path following, manual override and UI button exclusion. CI regression rejects furniture/off-map destinations and verifies a routed destination. Godot CI 38877092389 SUCCESS at source SHA 807e9710c1d5557de2f5c7bda608bf86d592f5c4. **This is a room-scoped A* grid implementation, NOT NavigationMesh/NavigationAgent3D, no multi-region/dynamic obstacle support yet.** Web deployment run 38877148454 in progress at checkpoint. Phone touch/orbit and save regression pending device verification; M1.2b remains OPEN until checks. Orison character assets not touched. APK manual-only.

## M1.2b Web deployment evidence — 2026-10-16
`validate.yml` 38877092389 SUCCESS; `deploy-pages.yml` 38877148454 SUCCESS; Cloudflare deployment 2cebb94e-3de9-4fe4-9ac5-752fa702fce2 SUCCESS with source SHA 807e9710c1d5557de2f5c7bda608bf86d592f5c4. Production still protected by owner-only Access. Mobile tap/orbit/override visual QA not yet performed by Creator; room-grid A* is intentionally interim, full NavigationMesh remains planned. No APK.

## M1.2b route-smoothing follow-up + Orison handoff — 2026-10-16
Creator phone QA: tap-to-move works, but obstacle paths zigzag/turn too often. Added clearance-grid line-of-sight string pulling (`scripts/navigation/room_pathfinder.gd`): remove unnecessary A* intermediate steps while retaining blocked-cell checks, regression checks for direct and obstacle routes. CI run 38878018857 SUCCESS; Web deploy 38878115167 SUCCESS; Cloudflare 17ff0403-83b9-4a30-a65c-a78e51cc21b7 SUCCESS for source 181f11401c03984fc9c0f1c7d201c43cae346a49. Creator phone recheck of smoother path pending. Bridge `/DEDAL-Orison/creators-universe-lifesim/handoff/to-dedal/` contains Orison ACK msg-20261016-lifesim-002 and batch-02 ready msg-20261016-lifesim-003; man-02/woman-02 GLBs, metadata, QA reports and previews are present in private Drive. Orison claims idle/walk and five morphs, notes residual red eyes and hand-keyed walk slide; DEDAL independent GLB/Godot/visual/license acceptance NOT yet complete. Do not publish assets or call M1.3 closed. No APK.

## Orison batch-02 generic male real game integration — 2026-10-16
Creator requested actual test. SHA-256 verified `man-02/model.glb` dc744bf37d292051d806de3ce47588da4363407b175f9580b45dc5d4d6a27c9e and `woman-02/model.glb` 708416a8d5e0f7ec6d41769779ccc9e5704ee3046709acb12de592907cc7a15a. Independent binary GLB audit: both one skin, named idle_in_place + walk_in_place animations (159 channels each), five morph targetNames: shouldersWider, chestPectorals, armsMuscular, waistNarrower, bodyMuscular. Added **generic male** to public `assets/public/approved/humanoid.glb`, changed visual adapter loader to GLB. Godot runtime regression explicitly confirmed rigged activation, both clips, movement-based animation selection: run 38878997757 SUCCESS. Web build and Cloudflare Pages deployment workflow 38879079602 SUCCESS (source SHA 7d4d4b1e7c2d1c007b50edb762d5ed0e461a344d); deployment URL https://abe29d03.creators-universe-lifesim.pages.dev per workflow log. IMPORTANT security distinction: protected production website DOES NOT privatize public GitHub asset; the generic model is publicly downloadable from public repository. No Darian/private canon file committed. Consumer on-device visual, root pose, red eyes, foot slide, morph runtime sliders, performance and female gameplay are NOT verified. Orison metadata claims CC0 MakeHuman origin; independent legal chain-of-title not established. No APK.

## M1.3 Creator screenshot gait QA and pinch/loop fix — 2026-10-16
Creator tested man-02 on Redmi K70 Chrome and supplied four screenshots: model is visible and playable but severe wide arm/leg gait, abnormal joints, foot slide, and frozen raised-foot appearance after 1.1-second walk clip. This is negative DEVICE evidence for animation quality (gate OPEN). Engine forced imported idle/walk Animation.LOOP_LINEAR at runtime; connected two-finger pinch gesture to adjustable collision-aware camera distance (1.6–9.0 units), with gesture suppression of accidental tap-to-move. Godot validate runs 38880252665 and 38880344097 successful, including explicit animation loop assertions. Web deploy run 38880403354 SUCCESS; Cloudflare deployment 64c88aaf-7eee-4895-bf7f-877ad749ec0f status success for source 261c2af0b5d77432b74fa938f2bfdaf96e3d82f8. Phone verification for pinch zoom and animation looping pending; still not claiming realistic gait. Orison feedback `msg-20261016-lifesim-004-walk-quality-feedback.json` uploaded to game `handoff/to-orison/` Drive file 1qZDXlL8vOi8qqkp5hb-0cMBmtQQ2Xg0i, requested versioned batch-03 mocap-quality gait, contact, looping and visual QA. No private Darian files; APK not run.

### M1.3b — Physics-owned locomotion bridge [PLANNED]
From Creator-provided Walk Animation Research (16-10-2026):
- [ ] CharacterBody3D owns movement/collision; rigged clips are strictly in-place.
- [ ] Replace abrupt AnimationPlayer switching with AnimationTree idle/walk/run blending; retain animation loop and procedural fallback.
- [ ] Track measured stride length, cycle duration, reference speed, foot-contact phases and animation licensing in a versioned metadata contract. Do not guess batch-02 measurements.
- [ ] Match gait playback to physical character speed and tune unrealistically fast 4.2 units/second prototype walking without breaking joystick/tap navigation.
- [ ] Make owner-only QA scene with floor grid, speed/phase readouts, slow motion and foot-slide inspection.
- [ ] Automated rig/clip/blend tests, real-device animation and FPS gates, then batch-03 visual acceptance.
Creator confirmed pinch zoom and animation loop controls work on phone; gait remains unacceptable. Orison ACK-005 message appears in Drive but content currently reports zero bytes, so commitment details are unverified. Latest room-fill lighting commit 9f99ac657a8ff0e499c1732d7699df44ebfd5026 lacks confirmed CI/Web deployment; do not call it released.

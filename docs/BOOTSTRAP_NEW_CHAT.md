# New Chat Bootstrap — LifeSim

Use this when starting work in a fresh chat.

1. Open https://github.com/Ye-Shwethway/creators-universe-lifesim and verify default branch and latest commit.
2. Read AGENTS.md, README.md, docs/SLICE_EXECUTION_CONTRACT.md, docs/ARCHITECTURE.md, docs/ROADMAP.md, docs/CURRENT_STATE.md, docs/VALIDATION_MATRIX.md, docs/ASSET_POLICY.md.
3. Read skills/registry.yaml, docs/SKILL_EXECUTION.md, docs/RESEARCH_BASELINE.md; select and read task-matched SKILL.md files before implementing.
4. Inspect current scene/scripts, export_presets.cfg and CI workflows; check open PRs/issues and actual latest Actions status.
5. Identify the current milestone, incomplete operations and any Creator decisions; do not assume successful builds without logs.
6. Preserve public/private boundaries. Do not copy private Universe images, names, detailed canonical profiles or paid models into this public repository without explicit approval.
7. Compose the smallest needed task, propose actions when destructive/irreversible, execute, test, update checkpoint, verify remote state.
8. Reconcile roadmap, current-state, validation and affected docs at every slice completion; read back remote files. If sync incomplete, keep slice open.
9. Summarize what changed, latest commit, evidence, remaining risks and exact next step.

## Project essentials
Godot 4 + GDScript; mobile-first; browser-first playability with native Android APK export; Redmi K70 (12 GB) is target test device. The user wants a Sims-like hybrid life simulator centered on Darian, with physical training progression and eventually autonomous NPC life. Current public MVP uses generic placeholder art until Creator authorizes and supplies suitable assets.

## Session handoff template
Task | branch/commit | milestone | changed paths | test results | asset classifications | blockers | next step.

## Active development preference
Creator approved Web-first iteration on 2026-10-16. Test and deploy Web routinely; **do not trigger Android APK builds automatically**. Preserve manual `build-android.yml` for later cross-platform validation. Redmi K70 controls work, but floor fall/recovery bug was reported. Consult ROADMAP for latest slice status and CURRENT_STATE for verification evidence.

## CI simulation regression — 2026-10-16
Creator device-confirmed Cloudflare owner login. Added tests/runtime_regression.gd to CI for action transitions, save clamping/counts, corrupt save handling and procedural visual fallback. Found/fixed shutdown detached-player save bug. Validate run 38874462587 SUCCESS (13 assertions); Web deploy run 38874646788 SUCCESS, Cloudflare deployment 978f05aa-afd9-43fd-aaf2-9522e28b96da success, matching commit 926f0d00ee3c8e1fb62a5cc7f6c9979e196cb22e. Browser runtime on new deploy not independently retested, APK not triggered, Orison batch-02 not integrated.

## M1.3 orientation fix checkpoint — 2026-10-16
Procedural toes reoriented from -Z to +Z to match controller forward; 2 new regression assertions. Godot CI 38875577208 successful, Web workflow 38875645418 successful, CF 19575fa9-0f79-4ef2-aaff-a08cd055c53f commit 328e9143edfa0cff7512aaab87bd8e28fa553d5c successful. Browser visual device verification pending. Access untouched. No Orison asset or APK.

## M1.2b current-room Tap-to-Move slice — 2026-10-16
Implemented `LifeSimRoomPathfinder` clearance-aware AStarGrid2D for current 14×14 room with furniture exclusion; `LifeSimMobileControls` distinguishes right-side taps from camera drags and preserves left joystick; `scripts/main.gd` adds target disc, 3D ray-plane targeting, auto path following, manual override and UI button exclusion. CI regression rejects furniture/off-map destinations and verifies a routed destination. Godot CI 38877092389 SUCCESS at source SHA 807e9710c1d5557de2f5c7bda608bf86d592f5c4. **This is a room-scoped A* grid implementation, NOT NavigationMesh/NavigationAgent3D, no multi-region/dynamic obstacle support yet.** Web deployment run 38877148454 in progress at checkpoint. Phone touch/orbit and save regression pending device verification; M1.2b remains OPEN until checks. Orison character assets not touched. APK manual-only.

## M1.2b Web deployment evidence — 2026-10-16
`validate.yml` 38877092389 SUCCESS; `deploy-pages.yml` 38877148454 SUCCESS; Cloudflare deployment 2cebb94e-3de9-4fe4-9ac5-752fa702fce2 SUCCESS with source SHA 807e9710c1d5557de2f5c7bda608bf86d592f5c4. Production still protected by owner-only Access. Mobile tap/orbit/override visual QA not yet performed by Creator; room-grid A* is intentionally interim, full NavigationMesh remains planned. No APK.

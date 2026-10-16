# Current State / Handoff
Date: 2026-10-16
Stage: M0 repository bootstrap.

Decided: Godot 4 + GDScript, one public GitHub repository, GitHub Actions CI, Web build first and Android debug APK target, mobile-first Redmi K70 testing, hybrid direct/guided/autonomous life simulation, private asset separation.

This initial commit is a project skeleton and documentation, NOT a completed playable game. No CI run, APK installation, browser benchmark, morph target rig, licensed Darian mesh or private asset pack is verified by this checkpoint.

Next: inspect CI workflow outcomes; fix any export/SDK configuration; produce minimal playable M1 scene with touch controls. Never mark M0 closed until actual Web and APK artifacts have been checked and a phone runtime test is recorded.

Current risks: Godot version/export template compatibility; Android SDK provisioning on CI; WebGL2 browser performance; absent rigged/morphable character assets; no unauthorized public distribution of private art.

## Research and skills follow-up
2026-10-16: Added 9 task-specific skill contracts, registry, skill execution gate and official-doc research baseline. Existing Godot 4.3 CI is still provisional and unverified; no gameplay implementation or green dual-platform build claimed. Next: engine-version decision, validate CI, repair export workflow, then prototype under selected skills.

## Architecture research checkpoint (2026-10-16)
Added ADR-0001, ADR-0002, character assets assessment and V01–V12 validation matrix. Godot 4.7 stable series is proposed as migration target; exact patch and matching Android toolchain still need CI proof. No third-party model approved; no device test/verified export. Next execution: migrate/pin after checking 4.7 patch assets, then run CI and fix actual failures.

## Execution update — 2026-10-16
Updated validate/Web/Android workflows and project.godot from Godot 4.3 to 4.7-stable source references, plus Android 35/NDK r28b provisional SDK setup. See docs/CHARACTER_PIPELINE_SPIKE.md for MakeHuman research route. **These changes are committed but CI/Web/APK outcomes have not been verified.** V01–V06 remain PENDING until external run logs/artifact inspection and Redmi K70 testing. Debug signing and Android export settings may still require correction.

## CI pin follow-up — 2026-10-16
Verified upstream Godot 4.7.2-stable exists; updated project and all three CI workflows to the matching 4.7.2 editor/template version. Android workflow now generates a disposable debug key and supplies Godot debug keystore environment variables. **No completed GitHub Actions run has been verified in this session; no installable APK or working Web artifact is claimed.** Review action logs and export preset Android signing/toolchain on the next validation pass; device tests remain pending.

## Live CI verification — 2026-10-16
Direct workflow dispatch + bounded polling results:
- Validate Godot run 38855603349: completed success.
- Web export run 38855603531: completed success; artifact lifesim-web, 10,300,187 bytes, sha256:e85ccc3c4e65920f93e41da012abe6eac2b90f0a630759462cdc589e808ea75e.
- Android initially failed on deprecated setup-android v3 'tools', then missing sdkmanager after removal, then ETC2/ASTC property path. Corrected using setup-android@v4 and [rendering] textures/vram_compression/import_etc2_astc=true.
- Android run 38856054864: completed success; artifact lifesim-android-debug, 28,017,343 bytes, sha256:e76f68cd87c76ee15b81df80658905029f6b680cb0e63b4f24dc379e19b8ee28.
- These artifacts are short retention. **CI success proves export, not successful install/launch, signed package inspection, frame rate or phone browser runtime**. M0 physical device gate remains open.

## Cloudflare integration checkpoint — 2026-10-16
Created Direct Upload Pages project creators-universe-lifesim and linked custom hostname lifesim.drthorne.uk, with proxied CNAME. Cloudflare Git-source connect failed error 8000011, so use GitHub Actions+Wrangler workflow. Deployment workflow committed, but GitHub repo has no CLOUDFLARE_API_TOKEN/CLOUDFLARE_ACCOUNT_ID secrets and no Pages deployment yet; actual site is not live. See docs/DEPLOYMENT_CLOUDFLARE.md. Domain status pending last read.

## First Cloudflare production deployment — 2026-10-16
- GitHub secrets CLOUDFLARE_API_TOKEN and CLOUDFLARE_ACCOUNT_ID verified by metadata; values not read.
- First deployment run 38857787491 failed: Cloudflare Pages rejects single asset larger than 25 MiB. Godot index.wasm size 39,514,754 bytes.
- Added 12 MiB WASM chunk splitting and Pages Function that streams /index.wasm from 4 static chunks, avoiding 25 MiB asset limit.
- Retry run 38857984698 completed SUCCESS. Wrangler compiled functions, uploaded 13 files, and deployed production URL https://6e38abe1.creators-universe-lifesim.pages.dev.
- Cloudflare Pages API reported deployment 6e38abe1-e965-4660-ae81-f4c46d69d516 production/success; custom domain lifesim.drthorne.uk active, verification active.
- Direct HTTPS fetch of custom domain from available tools was not successful due to tool-side hostname resolution/access; mobile WebGL2 runtime and route-level streamed WASM have NOT been independently verified. Do not mark device/browser milestone closed.

## Current active implementation plan — 2026-10-16 (supersedes historical 'pending browser' notes)
Creator's Redmi K70 screenshot directly demonstrates that the hosted Godot Web scene renders with capsule, floor, light and camera on lifesim.drthorne.uk. This is a Web runtime visual smoke check, NOT touch/gameplay performance validation. Web+Android CI exports and Cloudflare deployment succeeded as documented above, while installed APK/device input remain untested. M0 is partially verified, not fully closed.
The next slice is **M1.1 mobile controls and viewport**, followed by M1.2 environment, M1.3 humanoid pipeline, and M1.4 hardening. See docs/ROADMAP.md and docs/SLICE_EXECUTION_CONTRACT.md for exact definitions and per-slice mandatory synchronization. Roadmap/current state/validation must be reconciled and read back on every completed slice. Do not claim automated monitoring continues outside an active work session.

## M1.1 latest checkpoint (2026-10-16)
Source SHA 32a9193fcb66b330b9745c309e0caa6ff585a9a3 introduced keyboard actions, physics capsule and touch joystick/camera HUD. Files: scripts/main.gd, scripts/characters/player_controller.gd, scripts/ui/mobile_controls.gd, project.godot. Godot validate run 38858928498 SUCCESS, Android build 38858830484 SUCCESS, Web build 38858928342 SUCCESS, Cloudflare deploy 38859007168 SUCCESS. Cloudflare production deployment 9819ff7e-2e51-4772-867b-8f6aaa536056 SUCCESS (source SHA 32a9193...). MOBILE CONTROLS on Redmi K70 are NOT yet tested, and APK install is not evidenced. M1.1 is DEPLOYED/PENDING DEVICE VERIFICATION, not closed. Follow docs/ROADMAP.md and docs/SLICE_EXECUTION_CONTRACT.md. No private assets added.

## Creator feedback & Web-first decision — 2026-10-16
Creator tested M1.1 on Redmi K70, confirmed touch movement and camera usable, and observed walking beyond the platform caused a permanent fall. This is device evidence for the controls, NOT complete scene validation. New policy: prioritize Web validation/deploy; Android APK remains manual-only and no longer routine per-slice; preserve existing Android build workflow. Implemented player fall recovery and movement bounds, plus first simple collision room and procedural furniture. These code changes still require fresh CI, Cloudflare deployment and Creator on-device recheck. M1.2 interactions remain incomplete.

## Web-first M1.2 room prototype verified — 2026-10-16
Creator confirmed M1.1 controls usable on Redmi K70; observed unrecoverable edge fall. Code introduced bounds + respawn and basic procedural four-wall room with two solid props. Godot validation run 38859675610 success; Web build run 38859675605 success; Cloudflare Pages production deployment dcaf0886-cec5-4db4-a74a-9879c3da4d4c success, source 18a5eda9204ce379d250834dd8ceb6db4679dfb6. APK build NOT triggered per Creator Web-first/manual-APK preference. Live mobile recheck for fall recovery and room collision still pending; interaction system has not been implemented. M1.2 remains IN PROGRESS.

## Latest Creator on-device QA — 2026-10-16
Three landscape Redmi K70 browser screenshots were supplied, showing 3D room, capsule, furniture, HUD and changing camera views at lifesim.drthorne.uk. Creator confirms no further fall through/over floor boundary and object contact/collisions work. Record M1.1 recovery fix and M1.2 room/collision as DEVICE_VERIFIED by Creator feedback. M1.2 interaction prompt/button and event hook remain missing; slice remains OPEN. Web-first development continues; APK manual-only.

## M1.2 interaction deployment — 2026-10-16
Source `d28755d0b81846ac2e11101d141520dee9f17c61`: scripts/main.gd gained nearest-object proximity check, contextual USE button and usage count with console event. Godot validate run 38860662402 SUCCESS; deployment run 38860715373 SUCCESS; Cloudflare production deployment 25c4981a-8a3d-4a29-a952-ec1cad65ab92 SUCCESS and SHA matched. M1.2 device verification for interacting/tapping is still required; no persistent event bus or saves, no APK built. Current status DEPLOYED / DEVICE PENDING.

## Interaction QA and timed-action checkpoint — 2026-10-16
Creator screenshot verifies Training Box contextual USE succeeded and incremented counter on Redmi K70. Implemented scripts/simulation/action_engine.gd plus integration into scripts/main.gd: idle/active timed action, started/completed/cancelled events, one-at-a-time guard, per-target completion count. Godot validation run 38861694481 SUCCESS. This new timed behavior itself remains untested on physical device, is session-only and does not yet persist. APK remains manual-only.

## Timed-action Web deployment — 2026-10-16
Cloudflare production deployment 76930774-8bc2-4b72-a83f-207a89dd646c SUCCESS for code commit 44699162a130e2e7d7b69d143809ff39c31095de; headless validation 38861694481 SUCCESS. This is a new version of the interaction logic. The prior Creator phone screenshot verifies the former immediate-counter interaction, not the new timed completion. Phone validation of the 1.8-second action lifecycle remains open. APK build remains manual-only.

## 2026-10-16 Local save prototype
Creator screenshot verifies timed action started, not completion. Versioned allowlisted usage counter save added with load on startup and save on completion. Godot validation run 38862100255 succeeded; Pages deploy run 38862189075 succeeded. Browser reload persistence untested. Android manual-only.

## Latest Creator device persistence verification — 2026-10-16
Creator reports Training Box used 3 times, exited/reopened LifeSim, then used one additional time. Screenshot shows `Training Box completed (4)`. This verifies basic local usage-count save/load across the reported revisit on Redmi K70. Does not establish comprehensive world saves, storage durability against browser data clearing, schema migration or corruption handling. Web-first, Android manual-only continues.

## World pose persistence slice — 2026-10-16
Added position/yaw/pitch to existing v1 local save and restore, with safe bounds and periodic saves. Retains prior counters; schema/version unchanged. Godot validation 38862774933 SUCCESS. Web deployment source verification and Redmi K70 refresh/reopen test pending. APK remains manual-only.

## World pose save deployment verified — 2026-10-16
Godot validate run 38862774933 SUCCESS. Cloudflare deploy run 38862907783 SUCCESS, Cloudflare deployment 81cbaf4a-23d5-4a34-a58c-139554497bd3 production/success at commit 9f8caa8bfa5ab1ff9918e327c4602d96218f18f2. Position/camera restore across reload is NOT phone-verified; old count-only save compatibility implemented but not regression-tested on physical device. APK manual-only.

## Latest Creator QA — 2026-10-16
Creator confirmed LifeSim reopened with capsule at previous position; screenshot shows Training Box completed (5). Local avatar position persistence and counter continuity verified on Redmi K70. Camera orientation specifically not established. Next: prevent camera clipping into room walls and refine mobile visual HUD; Web-first, APK manual-only.

## M1 camera occlusion patch — 2026-10-16
Creator Redmi K70 feedback verifies restored avatar location on returning to web game and counter continuity (screenshot shows Training Box completed 5). Added physics raycast from avatar focus to desired chase camera point, excluding player and correcting camera position before wall clipping. Source commit 6af231af4cfb8157c7f6b38ee476cb43b4b1c070. Validate run 38863320136 SUCCESS; deployment run 38863369314 pending read-back. Physical on-device camera collision not yet verified. Web-first, APK manual-only.

## Camera Web deploy verification — 2026-10-16
GitHub deploy run 38863369314 completed SUCCESS; Cloudflare production deployment ad4bcb3b-fbc2-49fc-8ecb-776c73900275 SUCCESS for source SHA 6af231af4cfb8157c7f6b38ee476cb43b4b1c070. Camera occlusion correction is deployed, not yet Redmi K70 verified. APK intentionally not built.

## M1.3 procedural human bridge — 2026-10-16
Creator screenshot shows scene with walls partly black but camera behavior improved. Replaced capsule visual with original procedural humanoid torso/head/arms/legs, locomotion limb swing; added ambient light and two-sided materials for simple wall visibility. Existing physics/avatar save/interaction logic preserved. Validation run 38865092817 SUCCESS. New humanoid visual, lighting and GPU behavior remain device-untested; actual MakeHuman GLB rig/morphs untested. APK manual-only.

## M1.3 Web deployment confirmed — 2026-10-16
Godot validate 38865092817 SUCCESS; Cloudflare deploy workflow 38865152354 production release succeeded; Cloudflare deployment 1802de7e-19c0-47cf-b49b-3e63a16cfe66 SUCCESS from source commit 2726fa3545a7140718cfa7c1717d97fba8300af2. New procedural humanoid is NOT MakeHuman, and phone runtime render/lighting changes are not yet verified. Keep M1.3 OPEN, APK manual-only.

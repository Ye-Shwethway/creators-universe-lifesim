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

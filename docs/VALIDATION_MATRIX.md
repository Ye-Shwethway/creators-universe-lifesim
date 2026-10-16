# Execution and Quality Gates — LifeSim
Date: 2026-10-16
No checks marked PASS without direct evidence.

| Gate | Required observed evidence | Current |
| --- | --- | --- |
| V01 Godot engine pin | exact patch URL, hash, matched templates and config | PENDING |
| V02 Headless import | successful command log for full project | CI PASS — validate run 38855603349 |
| V03 Script smoke | zero parser errors plus smoke startup | CI PASS — validate run 38855603349 |
| V04 Web build | archive manifest + successful export + HTTP served smoke | PARTIAL: export CI success and Cloudflare production success; user screenshot demonstrates rendered app; direct HTTP/console checks not separately captured |
| V05 Web on phone | Redmi K70 Chrome opens; touch, input, stability | PARTIAL: Creator screenshot 2026-10-16 shows 3D capsule/floor rendered on lifesim.drthorne.uk; interactive controls/performance not yet tested |
| V06 Android APK | signed installable arm64 build + install/launch log | PARTIAL: APK artifact produced; signing/install/launch not device-verified |
| V07 Gameplay determinism | same seed/replay gives identical state | PENDING |
| V08 Save integrity | write/load/migrate/corruption detection tests | PENDING |
| V09 Character asset | verified license, rig/morph/anatomical review | PENDING |
| V10 3D performance | measured FPS, p95 frame time, memory, heating | PENDING |
| V11 Privacy | no private media/canon/secrets/public artifacts | PENDING |
| V12 UI accessibility | touch target, aspect safe area, resize and modes | PENDING |

Suggested targets (NOT measured): Web 30 FPS stable / native 30–60 FPS when feasible. Performance acceptance is device-evidence based, not merely CI success.

Every task receipt includes source-version SHA, skill files read, specific test commands, run URLs, outcomes and unknowns.

## M1.1 checkpoint — 2026-10-16
Godot validate run 38858928498 SUCCESS; Web build 38858928342 SUCCESS; Android export 38858830484 SUCCESS; Pages deploy 38859007168 SUCCESS; Cloudflare production deployment 9819ff7e-2e51-4772-867b-8f6aaa536056 SUCCESS. Joystick, camera gesture, responsive HUD, APK installation, FPS and memory on Redmi K70 still require physical-device verification. M1.1 is DEPLOYED but not CLOSED.

## Creator direct mobile feedback — 2026-10-16
Redmi K70 Web controls: touch movement/camera verified working by Creator. Found fall-off-floor with no recovery. Code-side recovery and containment patch committed; fix requires new Web deployment and phone recheck. M1.2 room collision/furniture committed only; no interaction test. APK explicitly manual-trigger only under new Web-first policy; no routine APK run required for interim Web slices.

## Web-first boundary/room checkpoint — 2026-10-16
Godot CI 38859675610 SUCCESS; Web CI 38859675605 SUCCESS; Pages production deployment dcaf0886-cec5-4db4-a74a-9879c3da4d4c SUCCESS. Creator previously verified joystick/camera but observed walking off edge and permanent fall; code fix now deployed, NOT yet verified on Redmi K70. Collision room and procedural props exported, not yet verified on device. APK intentionally not triggered; manual-only policy applies.

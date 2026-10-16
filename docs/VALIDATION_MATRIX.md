# Execution and Quality Gates — LifeSim
Date: 2026-10-16
No checks marked PASS without direct evidence.

| Gate | Required observed evidence | Current |
| --- | --- | --- |
| V01 Godot engine pin | exact patch URL, hash, matched templates and config | PENDING |
| V02 Headless import | successful command log for full project | CI PASS — validate run 38855603349 |
| V03 Script smoke | zero parser errors plus smoke startup | CI PASS — validate run 38855603349 |
| V04 Web build | archive manifest + successful export + HTTP served smoke | PARTIAL: Web export artifact produced, browser/HTTP smoke not verified |
| V05 Web on phone | Redmi K70 Chrome opens; touch, input, stability | PENDING |
| V06 Android APK | signed installable arm64 build + install/launch log | PARTIAL: APK artifact produced; signing/install/launch not device-verified |
| V07 Gameplay determinism | same seed/replay gives identical state | PENDING |
| V08 Save integrity | write/load/migrate/corruption detection tests | PENDING |
| V09 Character asset | verified license, rig/morph/anatomical review | PENDING |
| V10 3D performance | measured FPS, p95 frame time, memory, heating | PENDING |
| V11 Privacy | no private media/canon/secrets/public artifacts | PENDING |
| V12 UI accessibility | touch target, aspect safe area, resize and modes | PENDING |

Suggested targets (NOT measured): Web 30 FPS stable / native 30–60 FPS when feasible. Performance acceptance is device-evidence based, not merely CI success.

Every task receipt includes source-version SHA, skill files read, specific test commands, run URLs, outcomes and unknowns.

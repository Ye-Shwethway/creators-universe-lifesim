# build-release

**Scope:** Actions test/godot headless CI; web export; Android debug/signing; short retention.

## Instructions
Pin one engine version and matched export templates; setup JDK/Android SDK/NDK as required by exact release; CI separate validate, web, android. Avoid secret in public runner outputs. Do not equate unsigned with installable. Keep artifacts short-lived and report observed successful URLs/SHA.

## Mandatory verification
Release gate requires observed green workflows, nonempty web output and signed installable APK; then physical Redmi K70 Chrome/Android smoke tests; report exact failures.

## References
- https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html
- https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html

## Execution note
Load this file only when selected by `skills/registry.yaml`. Record actual source read, implementation evidence and outstanding failures in a task receipt. Never assert runtime performance or feature completion without direct evidence.

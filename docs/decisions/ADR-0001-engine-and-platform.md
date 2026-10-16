# ADR-0001 — Godot platform baseline
Status: accepted direction, toolchain verification pending
Date: 2026-10-16

## Context
Creator approved Godot 4 + GDScript for mobile-first, Web-first 3D LifeSim with Android native APK from one project. Initial GitHub CI was prematurely pinned to unsupported 4.3.

## Decision
Target Godot 4.7 stable series for an upgrade spike; select exact latest 4.7 patch only after runner/download/template verification. Version pin MUST be exact and identical for editor, export templates, config/features and CI. Do not promote existing 4.3 workflows as release-ready.

Use Compatibility renderer as cross-platform shared baseline (WebGL2 for Web). Offer native Android quality tier after real device proof, without splitting simulation code. Use GDScript rather than C# to preserve Web export.

Android baseline: JDK 17, version-matched official Android SDK/NDK/export requirements; signed *debug-installable* APK is a gate. Official 4.6 documentation lists build-tools 35.0.1, platform 35, NDK r28b and CMake 3.10.2.4988404. These numbers are research evidence, not 4.7 requirements until checked against the matching 4.7 documents.

## Rejected for now
Flutter+Three.js bridge (duplicated platform/runtime surface), Godot 4.3 pin (EOL), app-store-grade release before first physical device benchmark.

## Acceptance
Headless parse, Web artifact run in Redmi K70 Chrome, signed debug APK install and launch, observed FPS and frame-time reports. CI/build logs and hashes recorded. No unverified release claims.

References:
https://docs.godotengine.org/en/stable/about/release_policy.html
https://godotengine.org/download/archive/4.7-stable/
https://docs.godotengine.org/en/4.6/tutorials/export/exporting_for_android.html

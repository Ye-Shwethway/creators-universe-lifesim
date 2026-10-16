# Current State / Handoff
Date: 2026-10-16
Stage: M0 repository bootstrap.

Decided: Godot 4 + GDScript, one public GitHub repository, GitHub Actions CI, Web build first and Android debug APK target, mobile-first Redmi K70 testing, hybrid direct/guided/autonomous life simulation, private asset separation.

This initial commit is a project skeleton and documentation, NOT a completed playable game. No CI run, APK installation, browser benchmark, morph target rig, licensed Darian mesh or private asset pack is verified by this checkpoint.

Next: inspect CI workflow outcomes; fix any export/SDK configuration; produce minimal playable M1 scene with touch controls. Never mark M0 closed until actual Web and APK artifacts have been checked and a phone runtime test is recorded.

Current risks: Godot version/export template compatibility; Android SDK provisioning on CI; WebGL2 browser performance; absent rigged/morphable character assets; no unauthorized public distribution of private art.

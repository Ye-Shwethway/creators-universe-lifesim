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

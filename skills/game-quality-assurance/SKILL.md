# game-quality-assurance

**Scope:** Regression matrix; headless tests; performance; device review; release checklist.

## Instructions
Test logic independently from visuals, then scene import, export, runtime on actual device. Track separate pass states planned/code complete/CI verified/device verified/Creator approved. Never promote a visual accuracy claim from headless parser success.

## Mandatory verification
Maintain evidence of test command, runner/workflow URL, output hash, device/browser, observed FPS and blockers; fail closed on privacy exposure.

## References
- https://docs.godotengine.org/en/stable/tutorials/performance/optimizing_3d_performance.html

## Execution note
Load this file only when selected by `skills/registry.yaml`. Record actual source read, implementation evidence and outstanding failures in a task receipt. Never assert runtime performance or feature completion without direct evidence.

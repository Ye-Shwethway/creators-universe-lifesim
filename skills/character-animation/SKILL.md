# character-animation

**Scope:** Humanoid rig; glTF imports; blend shapes; animation tree; physique calibration.

## Instructions
Use consistent skeleton and mesh lineage; AnimationPlayer stores clips, AnimationTree manages state/transitions; validate morph target combinations and skin clipping in movement. Separate measured physiology from visual morph mapping. Private canon/approved model only in approved private pipeline.

## Mandatory verification
Test idle/walk/turn/exercise, arm/shoulder/chest extreme morphs, joint deformation, body measurement discrepancy and performance on device.

## References
- https://docs.godotengine.org/en/stable/tutorials/animation/animation_tree.html

## Execution note
Load this file only when selected by `skills/registry.yaml`. Record actual source read, implementation evidence and outstanding failures in a task receipt. Never assert runtime performance or feature completion without direct evidence.

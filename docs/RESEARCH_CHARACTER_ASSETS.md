# Character Asset Research and Acceptance Gate
Date: 2026-10-16

## Requirement
MVP needs original/redistributable neutral placeholder. Real Darian identity remains private; no private reference images or unpublished approved canon in public Git or distributables. Final real 3D physique requires a rigged mesh with authored shape keys that tolerate animation.

## Pipeline candidate comparison
1. Procedural primitive placeholder (accepted M0): free, zero external-license risk, **cannot** evaluate body realism or morph targets.
2. Blender-authored custom humanoid with rig and shape keys: complete control and potential private asset ownership, but modeling/rigging effort is substantial; Blender can operate locally/cloud-based creation workflows independent of final runtime.
3. Third-party pre-rigged glTF humanoid: quickest realistic prototype candidate, but redistribution, rigging, morph target coverage and license must be checked *per asset*. No package/model chosen yet.
4. Character generators (e.g., MakeHuman/MPFB-style workflows): evaluate output quality, license of generated models and redistribution, human shape morph support, Godot import and artist workload before any adoption.
5. Animation libraries (e.g., Mixamo-derived exports): terms of use, retargetability, animation format, attribution and distribution need review individually. No default legal approval.

## Candidate evaluation scorecard
Legal provenance | publicly redistributable? | glTF 2 import fidelity | skeleton/deformation | independently controllable shoulder/chest/arms/waist morphs | movement clipping | triangle/texture budget | Android/Web 30fps after heating | ability to privately tailor identity.

## Technical check
Build small glTF proof with Skeleton3D, Skin, MeshInstance3D, blend shape tracks and AnimationPlayer/AnimationTree. Apply extremes during idle, walk, squat, overhead press; inspect elbows, clavicle and texture distortion. Numerical circumference ↔ visual mesh mapping requires calibration; never infer exact inches from sliders alone.

## Status
NO third-party asset has been selected, licensed, imported or proven to meet the morph target requirements. Until this gate, public procedural placeholder only.
References:
https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/index.html
https://docs.godotengine.org/en/stable/tutorials/animation/animation_tree.html

## New sourced candidate: MakeHuman core assets
The MakeHuman Community states its **bundled/core graphical assets** and exported models are CC0; software source has separate AGPL/GPL licensing. This is a strong candidate for a procedural human base mesh, NOT proof it already supplies the required independent Godot blend shapes for body-part growth. Third-party repository add-ons may have different licenses. Test actual mesh, rig, deformation, export format, and build inclusion before acceptance.
Sources:
https://static.makehumancommunity.org/makehuman/faq/can_i_sell_models_created_with_makehuman.html
https://github.com/makehumancommunity/makehuman/blob/master/LICENSE.md

## Required test experiment
Produce a **generic** legally redistributable character, export glTF 2.0/GLB, import into Godot, inspect Skeleton3D + actual shape key names, measure combined morph behavior and verify web/Android performance. Do not claim acceptance based on vendor screenshots or license summaries alone.

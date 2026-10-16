# Research Baseline — 2026-10-16

The official Godot documentation is the primary source; pages on the stable branch can change and must be checked against the exact chosen engine release.

## Findings
- Godot 4 has Forward+, Mobile, Compatibility renderers; Web only Compatibility and WebGL 2. Desktop/mobile visual parity is not guaranteed. https://docs.godotengine.org/en/stable/tutorials/rendering/renderers.html
- 3D optimization includes LOD, occlusion culling, reducing transparency, MultiMesh and baked lighting; not all instancing optimizations apply to Compatibility. https://docs.godotengine.org/en/stable/tutorials/performance/optimizing_3d_performance.html
- AnimationPlayer supplies clips; AnimationTree controls state, blending and transitions. https://docs.godotengine.org/en/stable/tutorials/animation/animation_tree.html
- UI responsive scaling, stretch mode, anchors and mobile landscape baseline require real phone testing. https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html
- Android release/toolchains require release-compatible export templates, JDK, SDK and other toolchain setup. https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html
- Godot 4.3 documentation warns it is outdated/unsupported; initial repo 4.3 pin is legacy bootstrap, not an accepted final engine baseline. Review migration before CI closure. https://docs.godotengine.org/en/4.3/tutorials/3d/mesh_lod.html

## Unresolved research gates
- Decide exact supported Godot patch version and update all workflows/presets together after successful validation.
- Benchmark WebGL2 Compatibility renderer on Redmi K70; compare installed APK.
- License and technical evaluation of one rigged customizable humanoid mesh with actual morph targets.
- Export signing and Android toolchain must be demonstrated; current workflow has not been certified.
- Determine actual memory/frame budgets from real device captures, not guesses.

External packages/addons: none approved or installed in this baseline. Future additions require evidence, licensing, compatibility and impact audit.

# Character Pipeline Spike — MakeHuman → Blender → Godot
Date: 2026-10-16
Status: source-researched candidate, **not** imported or benchmarked

## What source research verifies
- MakeHuman Community publishes bundled/core graphical assets as CC0 and exported models as CC0; the MakeHuman software source uses AGPL and MPFB source uses GPL. Third-party addons may have distinct terms.
- The community documents an MHX2 → Blender (rig, shapes) → Godot workflow. This involves extra tooling, not a native direct Godot character editor. Transfer of *actual* independent physique morphs remains untested.
- Real-time character growth needs shared-topology shape keys plus compatible rig/animation, with morph deformation quality tested at extremes.

References:
https://static.makehumancommunity.org/about/license.html
https://static.makehumancommunity.org/makehuman/faq/can_i_sell_models_created_with_makehuman.html
https://static.makehumancommunity.org/relatedsystems/godot/tomcat/tomcat2.html
https://static.makehumancommunity.org/relatedsystems/godot/tomcat/tomcat3.html

## Reproducible POC plan
1. Obtain verified MakeHuman/MPFB release, core CC0 assets, Blender, and required legally reviewed Blender import addon. Record exact versions and URL hashes.
2. Generate **generic** placeholder humanoid. Save master Blender file privately until redistribution and CC0 provenance confirmed.
3. Inspect mesh topology, supported skeleton/skin weights, 4 real independent body shape keys (shoulders/chest/arms/waist). Create missing morphs by authored Blender shape keys, not fake scale-only claims.
4. Export GLB/glTF 2.0; import into the pinned Godot 4.7 editor. Verify MeshInstance3D blend_shapes, Skeleton3D and AnimationTree/AnimationPlayer clips.
5. Add QA scene exercising 0/25/50/75/100% morph extremes with walk, squat, overhead press and rotate poses. Detect body/cloth clipping.
6. Validate web Compatibility and Android export artifacts, then Redmi K70 runtime. Target measured frame time, loading and memory; no assumed 60 FPS.
7. Evaluate public-license suitability; only then add asset to assets/public with credits, hashes and license proof. Creator-approved Darian likeness remains private and out of public builds.

## Decision
MakeHuman: **candidate approved for research only**, not production acceptance.
No official asset model obtained, no blend shapes tested, no runtime test performed.

## M1.3 research/tooling implementation — 2026-10-16
Official MPFB export documentation recommends GameEngine materials and GameEngine rig for external engines, and preparing character geometry via export copy or baking/proxy workflows. Godot officially recommends glTF 2.0 (.glb/.gltf) for mesh + skin + animation transfer. See:
- https://static.makehumancommunity.org/mpfb/docs/exporting/index.html
- https://github.com/godotengine/godot-docs/blob/master/tutorials/assets_pipeline/importing_3d_scenes/available_formats.rst
- https://github.com/makehumancommunity/mpfb2/blob/master/LICENSE.md

Added `tools/audit_gltf.py`, test fixtures in `tests/test_gltf_audit.py`, and `.github/workflows/asset-audit.yml`. These check GLB/glTF metadata for linked skins, joint counts, animation count and morph targets. **Limitations:** metadata audit cannot certify skin deformation quality, license provenance, usable shoulder/chest/arm/waist morph controls, visual fidelity, animations, or real Godot scene import. A model is only accepted after a real MPFB-generated GLB is sourced, imported and rendered on Web.

Next execution: identify and produce CC0-only generic adult humanoid using MakeHuman core assets through MPFB/Blender with GameEngine rig and materials; export and evaluate actual GLB; keep existing procedural humanoid until it passes. No private Darian media.

## Instantiated Godot humanoid gate VERIFIED — 2026-10-16
Run https://github.com/Ye-Shwethway/creators-universe-lifesim/actions/runs/38868131012 completed SUCCESS. Godot scene actually loaded/instantiated after Blender normalization, runtime stdout: `LIFESIM_HUMANOID_INSPECT skeletons=1 bones=52 mesh_nodes=4 shape_keys=395 clips=0`. These are summed shape keys across mesh instances, not 395 unique editable body attributes. Thus structural rig/shape imports PASS; **zero imported animation clips**, and individual physique controls/body deformation, legal redistribution, and mobile Web performance remain UNVERIFIED. Candidate still only in isolated CI, not shipped. Next: animation retarget/author idle-walk and pose/morph semantic audit; preserve existing visual until gates passed. APK manual-only.

## M1.3 real Godot pose/morph assignment gate — 2026-10-16
CI run 38869052568 SUCCESS, runtime output `LIFESIM_HUMANOID_INSPECT skeletons=1 bones=52 mesh_nodes=4 shape_keys=395 clips=0` and `LIFESIM_POSE_MORPH_TEST bones=4 morph_assignments=5 PASS`. Verified four mixamorig limb bones accept pose rotations and five named physique blend shapes (shouldersWider, chestPectorals, waistNarrower, armsMuscular, bodyMuscular) accept/get 0.5 values on imported MeshInstance3D. This proves runtime setters, NOT realistic visual deformation or animation playback; 0 animation clips, license clearance and Web device acceptance still open. Candidate isolated in CI, live procedural humanoid remains. Web-first, APK manual-only.

## M1.3 actual visual QA result — 2026-10-16
GitHub Actions run 38869748123 SUCCESS after adding Xvfb/Mesa (prior run 38869523580 failed `Unable to open a display`). Workflow produced neutral, shouldersWider, chestPectorals, armsMuscular PNGs; artifact `humanoid-visual-qa` ID 12033236185. Downloaded and visually inspected all four images. Full human mesh is visible, but **skin highlights are heavily overexposed and morph differences are not convincingly legible** at current camera/lighting; therefore qualitative deformation/appearance gate remains OPEN. This is a visualization/test setup problem needing controlled illumination plus geometric delta measurements, not evidence that mesh/morph quality is acceptable. Candidate not published, asset/license clearance pending; no APK built.

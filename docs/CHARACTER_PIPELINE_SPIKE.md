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

# mobile-3d-rendering

**Scope:** Compatibility renderer; WebGL2; LOD; culling; lighting; adaptive budget.

## Instructions
Web export must function on Compatibility renderer. Begin with single dynamic key light, mostly simple opaque materials, texture atlases, LOD and limited view ranges; measure draw calls, frame time, memory and thermals. No unsupported Forward+/Mobile-only features in shared Web scenes. Android may later have separate quality tier.

## Mandatory verification
Capture real Redmi K70 Chrome FPS/p95 frametime, draw calls, memory, warm-device behavior; 30 FPS baseline target not certification; include fallback. No fake benchmarks.

## References
- https://docs.godotengine.org/en/stable/tutorials/rendering/renderers.html
- https://docs.godotengine.org/en/stable/tutorials/performance/optimizing_3d_performance.html

## Execution note
Load this file only when selected by `skills/registry.yaml`. Record actual source read, implementation evidence and outstanding failures in a task receipt. Never assert runtime performance or feature completion without direct evidence.

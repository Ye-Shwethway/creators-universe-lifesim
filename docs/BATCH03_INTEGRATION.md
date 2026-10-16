# Batch-03 locomotion integration — staged (OPEN)

Date: 2026-10-16. Branch: `feature/batch03-locomotion-adapter`.

## Observed independent input audit
- Orison-delivered male/female binary GLBs are valid-length glTF 2.0 containers with one skin (53 joints), two named clips (`idle_relaxed`, `walk_natural`; 160 channels each), and five named physique morph targets each.
- Original GLB hashes: male `6f886188aef3c91791d11768a07dd4cbb173a015b7538299b49cb0be75f6c1f7`; female `ea0b0d50f8654db7b6f0e103fc8b4d100a19394816cd2c0a9a9d156e6d00109a`.
- Both original GLBs contain ten sparse accessors. Locally generated dense-accessor test copies (not distributed or checked into this public repository) have zero sparse accessors, preserve named animations and morphs, and pass GLB structural length checks. Dense conversion alone does not prove correct Godot import or animation deformation.
- Orison *reports*, not independently established by Godot playback, a 1.667-second walk, 1.152 m stride and implied 0.691 m/s. The existing game controller uses 4.2 world units/s. Do not mark stride synced, stride contact validated, or realistic locomotion accepted.

## Patch scope
- Visual adapter accepts either batch-03 clip pair (`idle_relaxed` / `walk_natural`) or legacy pair (`idle_in_place` / `walk_in_place`), preferring the batch-03 pair if both exist.
- Legacy model, web production asset, movement controller, saves and APK unchanged.
- Measured gait metadata additionally requires matching `animation_clip`; current published batch-02 metadata remains `measured=false`.
- Runtime regression continues to assert batch-02 clip playback and falls back safely when required clips are absent.

## OPEN gates before integration into main / web deploy
1. Independently verify source license provenance, including BVH redistribution rights; producer CC0 assertion is not sufficient.
2. Import and visually inspect a dense candidate in Godot 4.7.2, verify skeleton, deformation, loop seam, foot contacts, material and mobile performance.
3. Resolve stroll speed vs gameplay velocity without ~6x clip speed; decide walk/run control scheme and test tap-to-move travel.
4. Run branch CI; inspect logs; merge only when supported evidence exists. Preserve batch-02 rollback and manually verify on Redmi K70.
5. Synchronize ROADMAP/CURRENT_STATE/VALIDATION_MATRIX and bootstrap pointers at slice closure; never claim M1.3 closed without device evidence and Creator acceptance.

Asset privacy: no private Darian/canon assets or new Orison GLBs committed by this staged branch. Android APK remains manual-only.

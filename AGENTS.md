# Agent Operating Contract — Creator's Universe LifeSim

Read in order: README.md → docs/BOOTSTRAP_NEW_CHAT.md → docs/ARCHITECTURE.md → docs/ROADMAP.md → docs/CURRENT_STATE.md → docs/ASSET_POLICY.md.

## Authority
- Creator-approved decisions override proposals. Never silently change canon.
- This repository is the public source of truth for executable code and technical documentation.
- Private Creator's Universe canon/reference media remain in their private owner; never infer authorization to publish.
- State the distinction between proposed, committed, CI-tested, device-tested, and Creator-approved.
- Read repository state before modifications; preserve existing files and use small reviewable changes.
- New chat: rebuild state from repository docs, live branch, open issues/PRs and CI evidence; do not pretend a previous chat remains executing.

## Mandatory domain skill hydration
- Before gameplay/rendering/UI/assets/build work, read `skills/registry.yaml` and route one primary skill with up to three supporting skills. Read selected `skills/*/SKILL.md`, `docs/SKILL_EXECUTION.md` and `docs/RESEARCH_BASELINE.md`. Record selected paths, observed sources and validation outcome. Missing evidence blocks completion claims.
- Current Godot 4.3 CI pin is provisional; research baseline documents version/SDK discrepancies. Validate and reconcile before build closure.

## Engineering
- Engine: Godot 4.x, GDScript, mobile-first 3D, web + Android dual-export target.
- Single simulation core. Keep simulation independent of scenes/UI and deterministic where possible.
- Hybrid control: Direct, Guided, Autonomous; explicit and reversible mode transitions.
- Game state is serialized/versioned; migration and load validation required.
- Separate public playable demo assets from private characters/creative data.
- Do not upload private reference art, secrets, copyrighted third-party assets or generated save data.
- Run validation and export tests before claiming a build is working. Report what was actually tested.

## Change protocol
1. Inspect existing source, architecture, current checkpoint, and GitHub Actions.
2. State scope, risks and acceptance criteria.
3. Implement minimal cohesive patch with tests and documentation.
4. Validate; update docs/CURRENT_STATE.md and roadmap status from evidence.
5. Read back resulting commit/CI artifacts. Report failures openly.

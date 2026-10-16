# Creator's Universe — LifeSim

Mobile-first, Sims-inspired character life simulation in **Godot 4 + GDScript**. Targets **Web (Godot Compatibility/WebGL 2)** and **Android APK** from one codebase. Repository is public; character references and private canon are **not**.

> Status (2026-10-16): **M0 foundation bootstrap**. A procedural placeholder scene exists. A playable game, verified web export and verified APK have **not** yet been demonstrated.

## Start here
- [Agent instructions](AGENTS.md)
- [New-chat bootstrap](docs/BOOTSTRAP_NEW_CHAT.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Implementation roadmap](docs/ROADMAP.md)
- [Current state / handoff](docs/CURRENT_STATE.md)
- [Asset protection policy](docs/ASSET_POLICY.md)
- [Public asset credits](assets/public/ASSET_CREDITS.md)

## Tech
Godot **4.3** pinned as the initial CI baseline (subject to testing/updating). Mobile-first UI and quality presets; compatibility renderer for browser exports. GDScript simulation supports proposed **Direct / Guided / Autonomous** hybrid control. Procedural test art only; real character progression needs a rigged and morph-enabled mesh.

## Project layout
```
AGENTS.md                       agent contract
docs/                           roadmap, bootstrap, architecture, state, assets
project.godot                    game project
export_presets.cfg               Web + Android presets (validation pending)
scenes/                          Godot scene files
scripts/                         game logic
assets/public/                   approved redistributable files
.github/workflows/               validate, build-web, build-android
```

## Run locally
Install official Godot 4.3 and open `project.godot`. Run with F6/F5 or `godot --path .`. The only current screen is a basic procedural geometry scene; no walking controls yet.

## CI and delivery
- `validate.yml`: headless import/parser/startup checks.
- `build-web.yml`: produces a short-lived Web export artifact; **not yet deployed** to Cloudflare Pages.
- `build-android.yml`: experimental unsigned Android debug export target; Android SDK/export/signing must be verified. Unsigned debug APK may not be installable until signing is configured.

Actions artifacts retain for one day. All CI success and on-device claims require observed run evidence.

## Privacy and licensing
No private Darian reference images, approved Universe canon or proprietary models in public Git history. Any model bundled into Web/APK output should be considered extractable. See [asset policy](docs/ASSET_POLICY.md).

## Immediate next work
Validate CI; correct Android export settings and signing; implement one controllable low-poly avatar and touch controls, benchmark Redmi K70, then Character Lab.

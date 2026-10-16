# godot-engineering

**Scope:** GDScript typed interfaces; scenes/resources; vetted addons; version/export pinning.

## Instructions
Prefer typed GDScript, small scene trees and composition; Resources only for serializable configuration with explicit serialization decisions. No addon/package until license/version/support/CI reproducibility assessed. Resolve engine version and templates together; avoid relying on 4.3 as long-term target without migration audit.

## Mandatory verification
Run Godot headless import/parser and smoke runtime; pin release & templates; preserve source/import metadata. Do not claim test results before Actions logs.

## References
- https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html

## Execution note
Load this file only when selected by `skills/registry.yaml`. Record actual source read, implementation evidence and outstanding failures in a task receipt. Never assert runtime performance or feature completion without direct evidence.

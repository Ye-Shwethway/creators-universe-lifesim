# game-ui-ux

**Scope:** Mobile-first landscape HUD; touch virtual joystick; camera; accessibility.

## Instructions
Control nodes with anchors/containers, DPI-safe tap targets, safe areas, pointer capture separation from camera drag. Manual / Guided / Autonomous switch has visible state and cancel action. No oversized headers or obstructed 3D content. Support keyboard and mobile touch with consistent commands.

## Mandatory verification
Review Redmi K70 portrait/landscape decision, aspect ratios, touch interactions and overlays; test UI scaling and pause/menu legibility.

## References
- https://docs.godotengine.org/en/stable/tutorials/rendering/multiple_resolutions.html

## Execution note
Load this file only when selected by `skills/registry.yaml`. Record actual source read, implementation evidence and outstanding failures in a task receipt. Never assert runtime performance or feature completion without direct evidence.

# Slice Execution & Synchronization Contract
Updated: 2026-10-16
Purpose: avoid drift between implementation, skills, roadmap, validation and new chats.

## Before a slice
1. Fetch live main branch and docs/ROADMAP.md, CURRENT_STATE.md, VALIDATION_MATRIX.md, AGENTS.md, skills/registry.yaml.
2. Choose task profile, hydrate exact relevant skills and research sources; confirm scope/dependencies.
3. Define acceptance checks and rollback scope. Code and assets may not silently alter private Universe canon.

## Implementation
- Prefer coherent small commits. For CI, dispatch and poll GitHub Actions, inspect failed job steps/logs, patch and retry without asking Creator to manually watch.
- Evidence levels: CODE_COMPLETE = committed; CI_VERIFIED = successful observed checks/exports; DEPLOYED = Cloudflare success; DEVICE_VERIFIED = real phone evidence for stated features, not an assumption; CLOSED requires applicable verification and explicit approval when mandated.
- No Web/APK equivalence assumption. Identify asset privacy and license compliance.

## Atomic-like completion protocol
After verification, update in one reconciliation cycle:
A. ROADMAP: slice status and checkboxes, next slice dependencies.
B. CURRENT_STATE: latest current checkpoint (date, SHA, CI run IDs, deployment ID, on-device feedback, blockers).
C. VALIDATION_MATRIX: only gates supported by evidence.
D. ADR, skills, asset manifest, deployment docs: only if decision or process changed.
E. BOOTSTRAP_NEW_CHAT: update authoritative pointers, not unnecessary historical duplication.
Commit and **read back** every touched file. If reconciliation is interrupted/partial, DO NOT mark slice closed; explicitly identify inconsistent paths and recover at next session start.

## Required receipt
Slice ID | chosen skills | baseline SHA | final SHA | changed paths | CI run URLs/conclusions | Cloudflare deploy ID | device evidence & limitations | privacy check | updated docs | remaining blockers | next action.

## No background promise
Monitoring means active in-session polling while running work; not continuous unattended monitoring unless separately scheduled with an automation.

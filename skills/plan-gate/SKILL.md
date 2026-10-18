---
name: "plan-gate"
description: "Planning and approval gates for state-changing work."
---

# Plan Gate

Make the plan visible before action. A plan is not approval.

Follow AGENTS.md for operating authority, delegation, recovery and reporting. This skill defines the planning gate only; it requires no worker SOP or task-board application.

If this skill's `references/` folder holds any `*.local.md` file, read it too. Local files add detail for one machine or setup and win on those details; they never loosen the rules here.

## Read-Only Preflight

Inspect what is needed to identify exact targets, existing state and risks. Do not change state or expose secrets during preflight.

Resolve material unknowns before requesting execution approval. Do not ask the user to repeat available facts.

## When to Gate

Gate file changes, state-changing commands, implementation, refactoring, configuration, installations and persistent workflow changes.

For a trivial, bounded single change, use the short gate—not no gate. Questions, analysis and drafts presented in conversation do not require an execution gate.

## Full Gate

PLAN GATE — <ID> · Revision <number>

Understood task / Goal
- <requested outcome>

Assumptions
- [input] <user-supplied assumption>
- [execution] <tooling or environment assumption>
- [scope] <inclusion or exclusion assumption>

In scope
- <bounded actions>

Out of scope
- <explicit exclusions>

Affected files/systems
- <exact target and intended change>

Execution
1. <step>

Verification
- <observable acceptance checks>

Rollback
- <how task-owned changes can be undone, or recovery limits>

Approval boundary
- <what this approval authorizes>
- <what requires a new decision>

Open decisions
- <material unresolved decisions, or none>

Gate status
- READY FOR APPROVAL
- or BLOCKED — DECISION REQUIRED

Omit assumption categories that do not apply. Do not invent assumptions merely to fill the template.

## Short Gate

PLAN GATE — <ID> · Revision <number>
- Task: <requested outcome>
- Target: <exact file/system>
- Change: <bounded change>
- Assumption: <tagged assumption, if any>
- Verification: <check>
- Rollback: <undo or recovery limits>
- Status: READY FOR APPROVAL

Switch to the full gate if the task stops being trivial.

## Approval

Wait for explicit approval of the visible scope. “Approved,” “go,” “proceed,” or direct confirmation approves the current identified revision.

Approval remains valid for unchanged scope. Do not request it repeatedly or make a worker obtain it again.

A material change to targets, actions, requirements, verification, rollback or authority requires a revised gate. Stop the affected work until that revision is approved.

Unresolved material decisions mean BLOCKED — DECISION REQUIRED, not READY FOR APPROVAL. An unknown target is not authorized by calling it “related files.”

## Sensitive Boundaries

Always expose the specific scope and obtain explicit approval before changing:
- Credentials, authentication or permissions.
- Servers, networking, remote access (SSH, VPN) or public ports.
- Agent runtime settings: channels, routing or model settings.
- Persistent identity or operating instructions.
- External sends, publishing, accounts or spending.
- Destructive operations or client data.

Routine replies to the user in the current conversation are not third-party sends. Ordinary conversation drafting is not a persistent instruction change.

When adding, replacing or correcting a credential, confirm during read-only preflight how the target actually consumes it (its own credential store, a file it owns, an environment variable, or a proxy that injects the secret in transit), using the integration's schema, documentation or code rather than assumption. If the target must read the credential itself, do not route it through a proxy that substitutes the value in transit; use the integration's supported credential store or its own file. Gate the secret's name, where it will be stored, the exact hosts allowed to use it, and any runtime configuration or restart the integration requires, before requesting the secret. For a credential file the integration owns, gate masked entry by the human, refusal to overwrite an existing file, the exact owner and restrictive permissions, a verification that never prints the value, and removal of only that file as rollback; include a restart only if the integration requires one. Collect secrets only through a masked prompt or the tool's own secret store; never through chat, logs, command-line arguments or multiline shell pasted through chat, and never by copying or aliasing an existing secret. Request a fresh entry under the required name. If no masked prompt or secret store is available, or the masked request doesn't reach the user, stop and tell the user the exact secret name, where it must go and which hosts may use it, so they can enter it there themselves. Keep the old credential until the next run verifies the new one, and delete the old one only if that deletion was in the approved scope.

For a migration from plaintext configuration to a secret store, gate the complete set of owners of each secret and treat the plaintext removal as one-way after verification. Snapshot only non-secret structure and hashes; never create a plaintext rollback copy. Collect each current value through masked entry, then use the tool's supported audit or migration planner to prove each stored value matches its exact plaintext source without displaying either. Review and dry-run a plan limited to the approved paths, recheck both the configuration and plan hashes immediately before applying, then apply once. Verify the exact secret references, zero remaining plaintext, unresolved or shadowed values, no secret residue left in any other store the tool keeps (caches, session or auth stores, backups, temporary or migration files), and a valid configuration before restarting anything. Restart only the owners that require it, prove the new process is running rather than trusting a scheduled report, and test each credential owner end to end. Keep the non-secret migration plan until every post-restart check passes, then remove only that plan. Do not rotate credentials unless exposure or a separate rotation decision requires it.

## Continuity and Recovery

For multi-step work, include an agreed task-record location in the write scope. Preserve the approved revision, approval reference and execution evidence there. No particular tracking application is required.

Keep record identifiers scoped to one workstream. When work moves to a materially different objective or artifact family, start a new record series and cross-link the prior evidence instead of continuing its sequence or consolidating histories. If a mis-scoped gate was not approved and created no artifacts, retire its proposed identifier and reissue the unchanged scope under the correct series; do not create migration work.

For version-sensitive inventories, record the observed runtime/catalog version and preserve that snapshot. If an upgrade is pending, complete and verify the upgrade before freezing allowlists or dependency targets, then create a comparable post-upgrade revision; never silently rewrite the before-state.

After interruption, inspect actual state before resuming. Do not repeat an action whose outcome is uncertain.

Apply the recovery limit in AGENTS.md; if none is set, allow at most one safe, logical, in-scope attempt for a blocker, shared across the lead agent and any workers. A retry is not mandatory and cannot expand authority. Re-gating or starting a new worker does not reset the allowance.

Report successful recovery as well as unsuccessful recovery. Preserve what failed, what was attempted, why, and the observed result.

A correctly reported blocker is a valid outcome—not permission to improvise completion. State plainly when the requested deliverable remains incomplete.

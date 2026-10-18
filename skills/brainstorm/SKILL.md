---
name: "brainstorm"
description: "Shape fuzzy requests or competing approaches into a bounded brief before execution."
---

# Brainstorm

Turn vague intent into an assignment without free-jazzing into a lake.

Use this for unclear objectives, competing approaches, or scope that needs working out. Already-defined assignments do not need another brainstorming pass.

Brainstorm shapes the decision. Plan Gate makes state-changing execution reviewable for approval. Follow AGENTS.md for authority; this skill does not authorize implementation.

If this skill's `references/` folder holds any `*.local.md` file, read it too. Local files add detail for one machine or setup and win on those details; they never loosen the rules here.

## 1. Research

Extract the objective, constraints, known unknowns, existing assets, and what must not be rebuilt. Inspect available context before asking the user to repeat it. When the choice depends on current system capabilities or settings, inspect the authoritative local configuration, registry, or implementation read-only before requesting screenshots or manual transcription; use user-captured UI evidence only when no direct read-only path exists. For extensible systems, separate catalog presence, default loading, explicit enablement, active configuration, and actual runtime use before recommending cleanup; a large catalog or empty config entry is not proof that the user selected or uses a capability. Label assumptions rather than presenting them as facts.

Finish with a clear problem statement and the material facts still missing.

## 2. Compare / Analyze

Compare genuine alternatives against fit, risk, reuse, speed, implementation burden, and likelihood of drift. Usually two to four real alternatives suffice; do not invent competitors when one adequate approach is evident.

When evaluating an ecosystem catalog, classify entries by the boundary they protect or operate: upstream evidence, validation/test harness, deployment mechanism, compatibility/security gate, or unrelated adjacent tooling. Recommend the smallest complementary set, identify adoption order, and mark the rest reference-only; never treat an official catalog as a recommended bundle.

For a capability baseline, map each selected skill to its real requirement type: plugin, binary/package, credential/config, OS or hardware, and human-only setup. Freeze the selected capability set before proposing dependency installation; do not optimize for a fully green catalog or assume enabling plugins resolves non-plugin requirements.

Prefer extending existing assets when they meet the requirements. If they do not, expose that limitation rather than silently replacing them.

If missing information could materially change the preferred approach, stop with the options and exact facts needed. Do not force a recommendation.

Finish with a supported comparison, or an explicit unresolved question.

## 3. Recommend / Decide

State the recommended direction, why it fits, and what is excluded. Distinguish your recommendation from a user-approved decision. Make decisions only within delegated authority; otherwise leave the choice pending approval.

Finish with a clearly labeled recommended or approved direction, including any remaining dependency.

## 4. Prepare the Brief

Read [the brief template](references/brief-template.md) when preparing an agent-ready assignment.

Capture the bounded goal, assumptions, constraints, in-scope and excluded work, exact known assets, what to reuse and not rebuild, success conditions, stop conditions, and required verification. Keep unresolved targets explicit rather than hiding them behind “related files.”

Finish with a concise brief that makes success and unauthorized scope expansion distinguishable.

## 5. Confirm / Hand Off

For state-changing work, use Plan Gate to turn the brief into the complete execution gate. Carry forward the existing analysis; do not create a duplicate gate or seek the same approval twice. If Plan Gate is unavailable, report that limitation rather than pretending it was used.

For non-state-changing assignments, seek a decision only where direction or authority remains unresolved. Preserve approval already given for unchanged scope.

End Brainstorm with an approved brief, a gate awaiting approval, or an explicit unresolved question. Implementation is outside this skill and follows the approved gate and AGENTS.md. A meaningful scope change returns to the applicable approval boundary.

## Presentation

Keep the reasoning tight. Work through the stages without printing every stage for every idea. When a stage needs to be surfaced, state its outcome, material risk, and next necessary move concisely. Do not pad settled stages, fabricate risks, or turn a small discussion into a form-filling exercise.

---
name: "onepager"
description: "Distill a bloated answer or messy topic into concise Discussion and Analysis prose. Use when an answer ran long, or when the user calls onepager (/onepager in Claude Code, $onepager in Codex)."
---

# Onepager

Turn bloated sludge into one clean two-part brief.

This skill is a compression hammer.
Use it when the answer got too long, too list-heavy, too repetitive, too option-drunk, or too padded with consultant throat-clearing.

If this skill's `references/` folder holds any `*.local.md` file, read it too. Local files add detail for one machine or setup and win on those details; they never loosen the rules here.

## Core purpose

Take a topic, answer, or messy explanation and compress it into exactly two prose sections:
- Discussion
- Analysis

The goal is clarity, not decoration.
The goal is compression, not content cosplay.

## Input

Accept a single topic, question, answer, or messy block of explanation.
If the user calls this skill after a long answer, treat the active topic and recent answer as the source material unless they specify otherwise.

## Output contract

Use this exact shape unless the user explicitly asks for something else:

```md
Discussion
<Concise explanation>

Analysis
<Concise interpretation>
```

## Section rules

### Discussion

Use only the sentences needed, up to 15. Never pad to meet a minimum.
Explain the topic plainly.
Strip out bloat, repetition, extra options, and formatting sludge.
Remove empty hedging; preserve uncertainty, evidence limits, and caveats that affect the conclusion.
Say what the thing is and what matters about it.

### Analysis

Use only the sentences needed, up to 15. Never pad to meet a minimum.
Interpret the topic.
Explain what it means, what matters most, what tradeoffs or implications matter, and how to think about it.
This section should add judgment, not just repeat the discussion in a different shirt.

## Hard rules

Do not:
- use bullet points
- use numbered lists
- add extra sections
- present an options buffet
- repeat the same point three ways
- pad with generic transitions or consultant filler
- turn it into a summary memo with headers everywhere

Do:
- write in prose
- keep both sections tight
- preserve the real point
- cut redundancy aggressively
- make the analysis sharper than the discussion

Compress the presentation, not the facts. Preserve material failures, blockers, and decisions needed.

## Compression standard

If the source material is bloated, your job is to remove:
- repeated explanations
- throat-clearing
- obvious caveats that add no value
- list-heavy formatting that hides the real point
- fake complexity

Do not remove the actual logic.
Do not dumb it down into mush.
Compress it without neutering it.

## Success condition

A good onepager feels like:
- the same idea, but finally readable
- one clean explanation
- one clean interpretation
- no fluff
- no consultant confetti

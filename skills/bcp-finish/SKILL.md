---
name: bcp-finish
description: Finish real work with a Builder-Challenger pass. The building agent hands its finished work to a different model (Codex or Claude, called read-only) that challenges it under the Builder-Challenger Protocol, loops for up to 5 rounds (the Operator can extend once), and presents the objection ledger to the Operator (the human who owns the work) for go/no-go. Use when work is ready for completion approval, when AGENTS.md says "Finish with a challenge", or when asked to run BCP, challenge this, or get a second-model review. Skip for quick, obvious, easy-to-undo changes.
---

# bcp-finish

The finish step for real work. One model built it; a different model attacks it; the Operator makes the call. Based on the Builder-Challenger Protocol v1.7 (`https://github.com/heithmurray/builder-challenger-protocol`, CC BY 4.0, Heith Murray).

If this skill's `references/` folder holds any `*.local.md` file, read it too. Local files add detail for one machine or setup and win on those details; they never loosen the rules here.

## When

- **Run it** before asking for completion approval on any work beyond a quick change. Don't wait to be asked.
- **Skip it** for quick work: obvious, small and easy to undo. Focused verification is enough.
- One topic per run: the change you're about to hand in.

## Roles

- **Builder:** you, the agent that did the work. You fix or answer every objection.
- **Challenger:** a different model, run read-only. It finds problems; it never edits files or writes deliverable text.
- **Operator:** the human who owns the work. Only the Operator approves, accepts a risk, extends the round limit, issues a truth override or REFRAME, or rules on scope. You relay between Builder and Challenger, and you may issue a standard `RESET — [instruction]` for format violations only.

## Who challenges whom

- The Challenger is always a different model family from the Builder, started headless in read-only mode. The pairings and exact commands are in `references/tools.md`.
- Use each tool's configured default model; don't pick one.
- Each call is a fresh session that starts with no shared history. Give it the full round input every time (see Handoff).
- Allow up to 10 minutes per call. Each round is usually 1 to 5 minutes.

## Handoff (what the Challenger gets)

Each round, write one prompt with these parts, in order:

1. `references/challenger-prompt.md`, the whole file (the role, the rules and the formats).
2. `ROUND [n] — BUILDER OUTPUT — v1.[n-1]`.
3. **Topic:** one sentence on what this change must achieve, in the Operator's words where you have them, plus the acceptance criteria.
4. **Where to look:** the repo path, base and head commits, the commands to see the diff (for example `git diff <base>..<head>`), and the files that matter.
5. **Builder's evidence:** the verification you ran and its results.
6. From round 2 on: your Builder Response (the Builder Response Format below) and the Challenger's last Objection Ledger, verbatim.

Nothing else. No commentary, no prior rounds beyond the ledger.

The Challenger may read files and run read-only commands to prove its points. Evidence tiers matter: running the code or the math beats citing a source, which beats opinion.

## The loop

The round limit is 5 unless the Operator set another before round 1. When the limit is reached without APPROVED, stop and ask the Operator. The Operator may extend it once, with a reason: `EXTEND — [current round] to [new limit]. Reason: [the specific work still open]`. There is no second extension; reaching the limit again is a deadlock.

1. **Round 1:** send the handoff. Save the Challenger's reply verbatim as round 1.
2. **Verdict REVISE or FAIL:** answer in the Builder Response Format:
   - Response to verdict.
   - Accepted objections (by ID): what you changed. For each one: "Objection [ID] was tier [X]. My revision changed [Y]. The proportion is appropriate because [Z]."
   - Rejected objections (by ID): reasons, with evidence of equal or higher tier.
   - Weak objection challenge.
   - Assumption responses.
   - Revisions made.
   - Remaining open questions.

   Make the revisions and commit them on the branch. Then send the next round's handoff.
3. **An objection that would change scope, behavior or design** isn't yours to fix silently. Stop and bring it to the Operator as a decision, with the Challenger's text verbatim.
   - A spec or plan you wrote yourself doesn't settle scope. Don't reject an objection by pointing to it. Only the Operator's words or a spec the Operator approved count. If scope is the only reason to reject, report it as "Operator scope ruling needed."
4. **Verdict PASS** counts only with a completed Sign-Off Checklist where the open count is zero and the final verdict is APPROVED. Otherwise treat it as REVISE.
5. **Round limit reached without APPROVED:** stop and bring the open ledger to the Operator. If the Operator extends (once), continue. Otherwise, or at the extended limit, it's a deadlock: ask the Challenger for a one-paragraph Final Position Statement, write your own, and bring both to the Operator.
6. **SELF-FAIL:** if the approach itself is broken, say so with the three required parts: (a) what's broken, (b) why it took the challenge to surface, (c) what would make a different approach work. Bring it to the Operator.

Never edit, trim or soften a Challenger reply. Never claim an objection is resolved; only the Challenger's ledger can mark it resolved.

## Where the record goes

- If the work has a change folder or task record, save the rounds there as `BCP-LEDGER.md`: each Challenger reply and each Builder Response, in order.
- Otherwise save them in a temporary folder outside the repo and include the final ledger in your report.
- Don't create new top-level folders for it.

## Report to the Operator (completion approval)

- The models used for Builder and Challenger, and the number of rounds.
- The final version and the Challenger's final verdict.
- The final Objection Ledger, verbatim.
- The Challenger's concessions and its unraised-risk self-audit, verbatim.
- Your verification evidence.
- Every interpretation you made where the request was ambiguous (for example "days 6–29 charge nothing"), so the Operator can confirm or correct it.
- Anything that needs the Operator's decision: deadlock, SELF-FAIL, scope rulings, scope-changing objections, risks to accept.
- Then ask for go or no-go. Pushing, merging and publishing wait for the Operator's go.

## If the Challenger can't run

1. Retry once. If a model error mentions an unsupported model, report it; don't silently switch models.
2. If the other tool is still unavailable, run the same loop with your own tool's headless read-only command as the Challenger (see `references/tools.md`). It's a fresh session with no shared context.
3. Label the whole result **SELF-CHALLENGE** in the report, and say why the second model wasn't available. A self-challenge shares the Builder's blind spots, so the Operator should weigh it lower.
4. Never skip the step silently.

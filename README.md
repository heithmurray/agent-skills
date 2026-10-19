# Agent Skills

Four skills I use every day to keep AI agents honest and useful. Each one fixes a specific way agents go wrong. Each works on its own: use one, or all four. The one link between them: when brainstorm's brief leads to changes, it hands off to plan-gate if you have it, and says so if you don't.

A skill is a plain-text playbook (a `SKILL.md` file) that an agent loads only when the job calls for it. These follow the open [Agent Skills](https://agentskills.io) format, so they work in Claude Code, Codex and other tools that read it.

— Heith Murray

## The problems, and the fixes

### "The agent ran off and built the wrong thing."

You gave it a fuzzy idea, and it filled the gaps with its own guesses.

**[brainstorm](skills/brainstorm/SKILL.md)** turns a fuzzy request into a clear assignment before any work starts. The agent checks what already exists, compares a few real options, recommends one, and writes a short brief: the goal, what's in and out, what not to rebuild, and how you'll know it's done. It builds nothing.

> *Example:* "I want something to track our leads" becomes a brief that says: use the spreadsheet you already have, add three columns, don't build a CRM, and done means every lead from the website lands there within a day.

### "The agent changed things I didn't approve."

It edited files, ran commands or touched a setting, and you only found out afterward.

**[plan-gate](skills/plan-gate/SKILL.md)** makes the agent show its plan before it changes anything: exactly what it will touch, how it will check the result, and how to undo it. Nothing happens until you say go. Small changes get a short gate; big ones get the full form. Passwords, servers, publishing, spending and deletes always need your explicit yes.

> *Example:* before it renames a folder, you see the folder, the three files that point to it, how it will confirm the links still work, and how to put everything back.

### "The answer is too long to read."

You asked a question and got a wall of bullet points, options and caveats.

**[onepager](skills/onepager/SKILL.md)** cuts it down to two short sections of plain prose. **Discussion** says what it is; **Analysis** says what it means. The facts stay, and the padding goes.

> *Example:* a 900-word comparison of three tools becomes two paragraphs that end with which one fits and why.

### "The agent said it was done, and it wasn't."

It sounded confident, and it was wrong.

**[bcp-finish](skills/bcp-finish/SKILL.md)** has a *different* AI model review the work, read-only, before the agent hands it back. The reviewer's job is to find what's wrong. They go back and forth in a fixed format for up to five rounds. If they still disagree, it stops and asks you whether to allow a few more rounds or make the call yourself. You get the list of objections and how each one was settled, and you make the final call.

> *Example from building this repo:* the safety check that scans for leaked passwords looked finished. The reviewing model showed that a password added during a merge would slip past it. The fix was tested, and the reviewer confirmed it before anything was published.

It needs two AI tools installed and signed in: Claude Code calls Codex, or Codex calls Claude. The exact commands are in [`skills/bcp-finish/references/tools.md`](skills/bcp-finish/references/tools.md). With only one tool, it runs a weaker self-review and labels it that way.

## Install

Copy the skill folders to where your tool looks for skills.

**Claude Code** (reads `~/.claude/skills`):

```bash
git clone --depth 1 https://github.com/heithmurray/agent-skills.git && mkdir -p ~/.claude/skills && cp -r agent-skills/skills/* ~/.claude/skills/
```

**Codex** (reads `~/.agents/skills`):

```bash
git clone --depth 1 https://github.com/heithmurray/agent-skills.git && mkdir -p ~/.agents/skills && cp -r agent-skills/skills/* ~/.agents/skills/
```

On Windows, run these in Git Bash. Want just one skill? Copy just that folder.

Then ask for a skill by name ("brainstorm this", "plan-gate it", "onepager that", "run BCP"), or call it directly (`/onepager` in Claude Code, `$onepager` in Codex). Agents also pick a skill up on their own when the job matches its description.

**A tip if you use more than one AI tool:** keep one copy of the skills in a folder you own, and link each tool's skills folder to it. Then an edit you make shows up everywhere, instead of leaving you with three copies that slowly drift apart.

## Good to know

- **brainstorm and plan-gate defer to your `AGENTS.md`** (the instructions file many AI tools read) for who may approve what. If you don't have one, they fall back to asking you.
- **To make bcp-finish automatic,** add a line like this to your `AGENTS.md`: *"Finish with a challenge: before calling anything beyond a quick, obvious change done, use the bcp-finish skill and show me the objection ledger."*

## Credit

bcp-finish puts the [Builder-Challenger Protocol](https://github.com/heithmurray/builder-challenger-protocol) into practice. The protocol has the full rules, the reasoning behind them and a prompt pack for running it by hand.

## License

[MIT](LICENSE). Use them, change them and share them, including in paid work. Keep the copyright notice.

<sub>This repo runs a leak check (`scripts/leak-check.sh`) on every push. It flags anything private after the push, so it can't take back what's already published. Run it yourself before pushing.</sub>

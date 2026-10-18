# Agent Skills

Four skills I use every day to keep AI agents on track: get the idea straight, get the plan approved, keep the answers short, and have a second model check the work before I sign off on it.

A skill is a plain-text playbook (a `SKILL.md` file) that an AI agent loads only when the job calls for it. These follow the open [Agent Skills](https://agentskills.io) format, so the same files work in Claude Code, Codex and other tools that read it.

— Heith Murray

## The four skills

| Skill | What it does, in plain language |
|---|---|
| **brainstorm** | Turns a fuzzy request into a clear assignment. The agent looks at what already exists, compares a few real options, recommends one, and writes a short brief: the goal, what's in and out, what not to rebuild, and how you'll know it's done. It doesn't build anything. |
| **plan-gate** | Makes the agent show its plan before it changes anything: exactly what it will touch, how it will check the result, and how to undo it. Nothing happens until you approve. A small change gets a short gate; a big one gets the full form. Credentials, servers, publishing, spending and deletes always need your explicit yes. |
| **onepager** | Cuts a long, list-heavy answer down to two short sections of plain prose: Discussion (what it is) and Analysis (what it means). Same facts, a fraction of the reading. |
| **bcp-finish** | Before the agent says "done," a different AI model reviews the work, read-only, and tries to find what's wrong. They go back and forth in a fixed format for up to five rounds. If they still disagree, it stops and asks you whether to allow a few more rounds or make the call yourself. You get the list of objections and how each one was settled, and you make the final call. |

## How they fit together

```
shape the idea  →  gate the plan  →  distill  →  challenge the finish
  brainstorm        plan-gate        onepager       bcp-finish
```

1. **brainstorm** turns "I want something like X" into a brief.
2. **plan-gate** turns the brief into a plan you approve before any change is made.
3. **onepager** keeps the reports you read along the way short. Use it anywhere.
4. **bcp-finish** has a second model challenge the finished work before it comes back to you for go or no-go.

Each one works on its own. You don't need all four.

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

On Windows, run these in Git Bash, or in PowerShell use `$HOME\.claude\skills` (or `$HOME\.agents\skills`) with `Copy-Item -Recurse`.

Want just one skill? Copy just that folder.

Then use it: ask for it by name ("brainstorm this", "plan-gate it", "onepager that", "run BCP"), or call it directly (`/onepager` in Claude Code, `$onepager` in Codex). The agent also picks a skill up on its own when the job matches the skill's description.

## Good to know

- **AGENTS.md sets the authority.** brainstorm and plan-gate defer to your project's `AGENTS.md` for who may approve what. If you don't have one, the skills fall back to "ask the human."
- **bcp-finish needs two tools.** It calls the other model from the command line: Claude Code calls Codex, or Codex calls Claude. Both must be installed and signed in. The exact commands are in `skills/bcp-finish/references/tools.md`. With only one tool, it runs a weaker "self-challenge" and labels it that way.
- **Make bcp-finish automatic.** Add a line like this to your `AGENTS.md`: *"Finish with a challenge: before calling anything beyond a quick, obvious change done, use the bcp-finish skill and show me the objection ledger."*
- **Your own machine details go in `.local.md` files.** If a skill's `references/` folder holds a file ending in `.local.md`, the skill reads it as extra detail for your setup. This repo's `.gitignore` keeps those files out of git, so your paths and notes stay private. A leak check (`scripts/leak-check.sh`) looks through the whole history for a committed `.local.md` file, a personal machine path or a secret. GitHub runs it on every push. Run it yourself before pushing (`bash scripts/leak-check.sh`), because once something is pushed to a public repo, deleting it later doesn't take it back.

## Credit

**bcp-finish** puts the [Builder-Challenger Protocol](https://github.com/heithmurray/builder-challenger-protocol) (v1.7, by Heith Murray, licensed [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)) into practice. The protocol has the full rules, the reasoning behind them and a prompt pack for running it by hand.

## License

© 2026 Heith Murray. Licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/); full text in [LICENSE](LICENSE). You can use, change and share these skills, including in paid work, as long as you credit Heith Murray and link back here.

# Tools for bcp-finish

How to call the Challenger from each tool. Last checked October 2026 with Claude Code 2.1 and Codex CLI 0.154. Command-line flags change between releases; if one fails, check the tool's own help (`codex exec --help`, `claude --help`) before improvising.

Machine-specific notes (your paths, your login type, problems you've hit) go in a `*.local.md` file in this folder, such as `tools.local.md`. The skill reads it too, and it wins on those details.

## Pairings

| Builder | Challenger | Command, run from the repo root with the round prompt on stdin |
|---|---|---|
| Claude | Codex | `codex exec -s read-only --skip-git-repo-check -o <round-file> -` |
| Codex | Claude | `claude -p --permission-mode plan > <round-file>` |

- `-s read-only` (Codex) and `--permission-mode plan` (Claude) keep the Challenger from changing files.
- Don't add a model flag. Each tool uses its own configured default model.
- `<round-file>` lives in the change folder or a temporary folder, never loose in the repo.
- Self-challenge fallback (see SKILL.md): use your own tool's command from the table above.

## Known problems

- **Unsupported model:** some models aren't available on every login type (for example a ChatGPT subscription login versus an API key). If a call fails with that kind of error, report it to the Operator. Don't switch models on your own.
- **Codex sandbox file ownership (Windows):** files Codex creates may be owned by its sandbox account, so git can report "dubious ownership". Don't fix it with a broad `safe.directory = *`; add only the specific repo, or have the human create the files.
- **Codex calling Claude from inside its sandbox:** the sandbox has the network off by default, so the first `claude -p` launch can fail. Codex then asks for its normal escalation (approval) and the retry outside the sandbox works. In an interactive Codex session the human sees an approval prompt; that's expected. If escalation isn't possible, use the self-challenge fallback and say why.

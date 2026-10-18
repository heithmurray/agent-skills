#!/usr/bin/env bash
# Leak check for this repo. Run from the repo root before pushing; the GitHub
# Action runs the same script on every push and pull request.
# Checks every commit in the history, not just the latest one:
#   1. secrets (gitleaks)
#   2. machine-only *.local.md notes ever committed
#   3. personal home-folder paths (Windows, macOS or Linux) in any committed file
# Needs git and gitleaks. Set GITLEAKS to the gitleaks binary if it isn't on PATH.
set -u
GITLEAKS="${GITLEAKS:-gitleaks}"
fail=0

echo "== 1. Secrets (gitleaks, full history)"
# gitleaks' default log options skip merge commits' own changes; -m adds them.
if ! "$GITLEAKS" git . --no-banner --redact --log-opts="--full-history --all --diff-filter=tuxdb -m"; then
  echo "FAIL: gitleaks reported a leak or could not run."
  fail=1
fi

echo "== 2. Machine-only notes (*.local.md) anywhere in history"
# Lists every file in every commit, so adds, renames and merges are all covered.
# -z gives raw names (no quoting of accented or unusual characters).
notes=$(git rev-list --all | while read -r rev; do git ls-tree -r -z --name-only "$rev"; done | grep -zE '\.local\.md$' | tr '\0' '\n' | sort -u)
if [ -n "$notes" ]; then
  echo "$notes"
  echo "FAIL: a *.local.md file was committed. It stays in history even if deleted later."
  fail=1
fi

echo "== 3. Personal machine paths in any commit"
revs=$(git rev-list --all)
if [ -n "$revs" ]; then
  # git grep exits 0 on a match, 1 on no match, anything else on error. Only 1 passes.
  rc=0
  git grep -nIE '[A-Za-z]:[\/]Users[\/]|/Users/[A-Za-z]|/home/[A-Za-z]' $revs -- . || rc=$?
  if [ "$rc" -eq 0 ]; then
    echo "FAIL: a personal machine path is in a committed file. Move it to a *.local.md file."
    fail=1
  elif [ "$rc" -ne 1 ]; then
    echo "FAIL: the path check itself failed (exit $rc)."
    fail=1
  fi
fi

if [ "$fail" -eq 0 ]; then echo "PASS: no leaks found."; fi
exit "$fail"

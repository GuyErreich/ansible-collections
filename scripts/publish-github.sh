#!/usr/bin/env bash
# Create the public GitHub repo and push main/dev/staging.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
REPO="${REPO:-GuyErreich/ansible-collections}"

if [[ ! -d .git ]]; then
  git init -b main
fi

git add -A
if git diff --cached --quiet; then
  echo "Nothing to commit"
else
  git commit -m "$(cat <<'MSG'
Add guyerreich Ansible collections monorepo

Migrate outputs (GPL) and workstation (MIT) under one repo with
Action-Semver-Control releases and Galaxy publish on stable tags.
MSG
)"
fi

git branch -M main
git branch dev 2>/dev/null || true
git branch staging 2>/dev/null || true

if ! git remote get-url origin >/dev/null 2>&1; then
  gh repo create "$REPO" --public --source=. --remote=origin --description "Ansible Galaxy collections under guyerreich (outputs + workstation)"
fi

git push -u origin main
git push origin dev staging || true

echo
echo "Next:"
echo "  1. Install the GitHub App on $REPO"
echo "  2. Run ./scripts/setup-secrets.sh"
echo "  3. Tag 1.0.0 on main (or merge a release PR) to publish to Galaxy"

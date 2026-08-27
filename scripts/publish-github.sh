#!/usr/bin/env bash
# Create the public GitHub repo, push branches, open monorepo tracking issue,
# and optionally update the archived outputs repo README.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
REPO="${REPO:-GuyErreich/ansible-collections}"
OLD_OUTPUTS="${OLD_OUTPUTS:-GuyErreich/ansible-outputs-collection}"

if [[ ! -d .git ]]; then
  git init -b main
fi

git add -A
if ! git diff --cached --quiet; then
  git commit -m "Add guyerreich Ansible collections monorepo"
fi

git branch -M main
git branch dev 2>/dev/null || git branch -f dev main
git branch staging 2>/dev/null || git branch -f staging main

if ! git remote get-url origin >/dev/null 2>&1; then
  gh repo create "$REPO" --public --source=. --remote=origin \
    --description "Ansible Galaxy collections under guyerreich (outputs + workstation)"
else
  echo "Remote origin already set: $(git remote get-url origin)"
fi

git push -u origin main
git push -u origin dev || true
git push -u origin staging || true

# Tracking issue on Action-Semver-Control
if [[ -f scripts/semver-monorepo-issue.md ]]; then
  gh issue create \
    --repo GuyErreich/Action-Semver-Control \
    --title "Support monorepos with independently versioned packages" \
    --body-file scripts/semver-monorepo-issue.md \
    || echo "Issue create skipped (may already exist)"
fi

echo
echo "Repo: https://github.com/$REPO"
echo
echo "Manual next steps:"
echo "  1. Sign in at https://galaxy.ansible.com (claims guyerreich namespace) and create an API token"
echo "  2. Install your GitHub App on $REPO"
echo "  3. ./scripts/setup-secrets.sh"
echo "  4. After secrets are set, create tag 1.0.0 on main to publish:"
echo "       git tag 1.0.0 && git push origin 1.0.0"
echo "  5. Archive $OLD_OUTPUTS after replacing its README with scripts/archive-outputs-readme.md"

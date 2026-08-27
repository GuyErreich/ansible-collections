#!/usr/bin/env bash
# Interactive helper to set Galaxy + GitHub App secrets on this repo.
set -euo pipefail
REPO="${1:-GuyErreich/ansible-collections}"

echo "Setting secrets on $REPO"
echo "See scripts/setup-secrets.md for how to obtain each value."
echo

gh secret set GALAXY_API_KEY --repo "$REPO"
gh secret set GH_APP_ID --repo "$REPO"
gh secret set GH_APP_PRIVATE_KEY --repo "$REPO"

echo
echo "Done. Current secrets:"
gh secret list --repo "$REPO"

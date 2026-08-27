# Maintainer secret setup

These steps claim the Galaxy namespace and wire CI secrets. They cannot be automated from a sandbox.

## 1. Claim the `guyerreich` namespace

1. Sign in at [galaxy.ansible.com](https://galaxy.ansible.com) with your GitHub account (`GuyErreich`).
2. Galaxy auto-creates the `guyerreich` namespace on first login.
3. Open **Preferences → API token**, create a token, copy it.

## 2. Install the GitHub App on this repo

Install the same GitHub App used by [Action-Semver-Control](https://github.com/GuyErreich/Action-Semver-Control) on `GuyErreich/ansible-collections` (Contents + Pull requests write).

## 3. Set repository secrets

With 1Password / `gh` signed in:

```bash
gh secret set GALAXY_API_KEY     --repo GuyErreich/ansible-collections
gh secret set GH_APP_ID          --repo GuyErreich/ansible-collections
gh secret set GH_APP_PRIVATE_KEY --repo GuyErreich/ansible-collections
```

Paste each value when prompted. Never commit these values.

## 4. Verify

```bash
gh secret list --repo GuyErreich/ansible-collections
```

You should see `GALAXY_API_KEY`, `GH_APP_ID`, and `GH_APP_PRIVATE_KEY`.

## 5. Install Auto Semver Bot on this repo

Install the same GitHub App used by Action-Semver-Control on `GuyErreich/ansible-collections`, then swap the **Locked Branches** ruleset bypass actor from Admin to that Integration (id `2720857`) so release automation can update `staging` / `main`.

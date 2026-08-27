# ansible-collections

Monorepo for Ansible Galaxy collections under the **`guyerreich`** namespace:

| Collection | License | Purpose |
|---|---|---|
| [`guyerreich.outputs`](collections/ansible_collections/guyerreich/outputs) | GPL-3.0-or-later | Clean multiline stdout callback |
| [`guyerreich.workstation`](collections/ansible_collections/guyerreich/workstation) | MIT | Bootstrap macOS / Ubuntu / WSL workstations |

Each collection is licensed independently (see its `galaxy.yml` and `LICENSE`). The repo root has no single license.

## Install from Ansible Galaxy

```bash
ansible-galaxy collection install guyerreich.workstation guyerreich.outputs
```

## Develop locally

```bash
git clone https://github.com/GuyErreich/ansible-collections.git
cd ansible-collections
ansible-galaxy collection install -r requirements.yml
ansible-playbook playbooks/bootstrap.yml
```

`ansible.cfg` sets `collections_paths = ./collections` so the in-tree collections are used without a prior `ansible-galaxy collection install` of local paths.

## Releases

Versioning is **lock-step** across both collections via [Action-Semver-Control](https://github.com/GuyErreich/Action-Semver-Control):

1. Merge to `dev` / `staging` / `main` → action opens a `Release X.Y.Z` PR (updates both `galaxy.yml` + `CHANGELOG.md`).
2. Merge the release PR → action tags `X.Y.Z` (or `X.Y.Z-dev` / `X.Y.Z-rc`).
3. Stable tags (no `-dev` / `-rc`) publish both collections to [galaxy.ansible.com](https://galaxy.ansible.com).

## Secret setup (maintainers)

See [`scripts/setup-secrets.md`](scripts/setup-secrets.md).

## License

- `guyerreich.outputs` — GPL-3.0-or-later
- `guyerreich.workstation` — MIT

# guyerreich.workstation

Bootstrap a developer workstation on **macOS**, **Ubuntu**, or **WSL** with Homebrew, GitHub CLI, guided 1Password setup, Oh My Zsh `op`/`gh` helpers, and interactive gitconfig.

One role per **concern** — not per OS. A new platform is a new mapping in `roles/platform`, not `roles/macos`.

## Install

```bash
ansible-galaxy collection install guyerreich.workstation
```

`community.general` is installed automatically as a collection dependency.

## Secret policy

Stores **`op://` references only**, never resolved secrets. Do not commit `~/.config/gh/hosts.yml` or playbook output containing tokens.

## Quick start

No git clone required — install from Galaxy and run the bundled playbook by FQCN:

```bash
ansible-galaxy collection install guyerreich.workstation
ansible-playbook guyerreich.workstation.bootstrap --tags verify
ansible-playbook guyerreich.workstation.bootstrap
```

Read-only check first (`--tags verify`), then run the full bootstrap when ready.

Non-interactive example (copy and edit `examples/extra-vars.yml` from the installed collection path, or from this repo):

```bash
ansible-playbook guyerreich.workstation.bootstrap \
  -e onepassword_skip_guide=true \
  -e @extra-vars.yml
```

Partial re-run:

```bash
ansible-playbook guyerreich.workstation.bootstrap --tags shell,git
```

## Tags

| Tag | Role |
|-----|------|
| `platform` | Derive `workstation_*` facts |
| `brew` | Install Homebrew |
| `gh` | Install `gh` via Brew |
| `1password` | Guided 1Password setup |
| `git` | Git credential helper + optional identity/signing |
| `shell` | `$ZSH_CUSTOM/op_gh.zsh` |
| `verify` | Read-only summary |

## Develop in the monorepo

Clone [ansible-collections](https://github.com/GuyErreich/ansible-collections) only when hacking on this collection or running CI locally:

```bash
git clone https://github.com/GuyErreich/ansible-collections.git
cd ansible-collections
ansible-galaxy collection install -r requirements.yml
ansible-playbook playbooks/bootstrap.yml
```

`ansible.cfg` sets `collections_path = ./collections` so in-tree sources are used without reinstalling from Galaxy.

## License

MIT — see [LICENSE](LICENSE).

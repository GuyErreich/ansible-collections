# guyerreich.workstation

Bootstrap a developer workstation on **macOS**, **Ubuntu**, or **WSL** with Homebrew, GitHub CLI, guided 1Password setup, Oh My Zsh `op`/`gh` helpers, and interactive gitconfig.

One role per **concern** — not per OS. A new platform is a new mapping in `roles/platform`, not `roles/macos`.

## Install

```bash
ansible-galaxy collection install guyerreich.workstation
```

## Secret policy

Stores **`op://` references only**, never resolved secrets. Do not commit `~/.config/gh/hosts.yml` or playbook output containing tokens.

## Quick start

From the monorepo (recommended for interactive bootstrap):

```bash
git clone https://github.com/GuyErreich/ansible-collections.git
cd ansible-collections
ansible-galaxy collection install -r requirements.yml
ansible-playbook playbooks/bootstrap.yml
```

Non-interactive:

```bash
ansible-playbook playbooks/bootstrap.yml \
  -e onepassword_skip_guide=true \
  -e @examples/extra-vars.yml
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

## License

MIT — see [LICENSE](LICENSE).

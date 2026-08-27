# guyerreich.outputs

Ansible stdout callback that prints message-only task results as clean multiline boxed output.

This collection is a thin subclass of Ansible's default callback (`ansible.plugins.callback.default`) and is therefore licensed **GPL-3.0-or-later**.

## Install

```bash
ansible-galaxy collection install guyerreich.outputs
```

## Usage

In `ansible.cfg`:

```ini
[defaults]
stdout_callback = guyerreich.outputs.default_with_clean_msg
```

Or via environment:

```bash
export ANSIBLE_STDOUT_CALLBACK=guyerreich.outputs.default_with_clean_msg
```

A short alias is also registered:

```ini
stdout_callback = guyerreich.outputs.clean_msg
```

## Development

```bash
ansible-test sanity --docker
ansible-test units --docker --requirements
ansible-lint .
```

## License

GPL-3.0-or-later — see [LICENSE](LICENSE).

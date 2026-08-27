## Summary

`Action-Semver-Control` is currently single-version-per-repo. The new [`GuyErreich/ansible-collections`](https://github.com/GuyErreich/ansible-collections) monorepo ships two Galaxy collections (`guyerreich.outputs` and `guyerreich.workstation`) that need **independent** versions eventually. Today they are released in lock-step as a workaround.

## Requested features

1. **`--config` CLI flag** (and matching action input) so `Config(path=...)` can load a non-default config. `Config.__init__` already accepts `path`; it is never plumbed from `main.py`.
2. **Configurable `.semver.lock` location** (or one lock per package) so multiple packages in one repo do not share state.
3. **Component / tag-prefix option** so tags become `outputs-1.2.0` / `workstation-1.0.1` instead of a bare `1.2.0`, with matching publish workflow filters.
4. Optional: **per-package `changelog.file`**.

## Current workaround

The monorepo uses one root `auto_semver_config.yml` with both `galaxy.yml` files listed under `version_files`, and publishes both collections on every stable tag.

## Acceptance

- Two packages in one repo can bump/tag independently.
- Downstream Galaxy publish workflows can select which collection to publish from the tag prefix.

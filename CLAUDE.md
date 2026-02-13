# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal Ansible playbooks for provisioning Ubuntu workstations. Manages dotfiles, system packages, development tools, and desktop configuration. **Not intended to be run directly** — fork and customize first (username defaults to "jason" throughout).

## Key Commands

```bash
# Run the full playbook locally (requires sudo)
ansible-playbook local.yml

# Pull and run from remote git repo
ansible-pull -oKU 'ssh://git@github.com/user/repo.git'

# Test a single role (edit test.yml to change which role)
ansible-playbook test.yml

# Install external dependencies (geerlingguy.docker, community.general)
ansible-galaxy install -r requirements.yml
```

## Architecture

**Playbook execution flow** (`local.yml`): APT cache update → roles (core → desktop → vim → terraform → docker → nvm → go → k8s → flutter) → APT cleanup.

**Inventory**: `hosts` file defines a `dev` group with machines `ws-test` and `rocinante`. Group vars in `group_vars/dev.yml`, host-specific overrides in `host_vars/`.

**Zsh integration**: Each role deploys its own rc file to `~/.config/zshrc/` (e.g., `gorc.zsh`, `k8src.zsh`). The main zshrc sources all files in that directory.

## Roles

| Role | What it does |
|------|-------------|
| **core** | System user setup, sudoers, apt packages (git, zsh, tmux, ranger, curl, etc.), oh-my-zsh, gitconfig |
| **desktop** | Chrome, GNOME settings/keybindings, snap apps (Discord, Spotify, VS Code, Obsidian, etc.), Terminator config |
| **vim** | vim-nox, Vundle plugin manager, plugins installed via handler on vimrc change |
| **terraform** | tfenv/tgenv version managers with multiple Terraform/Terragrunt versions |
| **go** | Go binary install with checksum verification (version/checksum in `roles/go/vars/main.yml`) |
| **nvm** | Node Version Manager from GitHub |
| **k8s** | kubectl, k9s, kustomize, helm, kubectx |
| **flutter** | Flutter SDK via snap, Linux build dependencies |
| **geerlingguy.docker** | External role for Docker/Docker Compose |

## Conventions

- Roles are self-contained: each has `tasks/`, `files/`, `defaults/`, `handlers/` as needed.
- The `username` variable (set in `group_vars/dev.yml`) is used across all roles for paths and ownership.
- Desktop background image is overridden per-host via `host_vars/`.
- `test.yml` targets localhost with a local connection and inline vars — change its `roles:` list to test individual roles.

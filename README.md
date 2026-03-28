# dotfiles

My personal dotfiles for bash / git / vim, managed with **mise**.

This repository is designed to:
- be safe to publish (no personal information included)
- be reproducible on a new environment in minutes
- work mainly on WSL (Linux), but extensible to macOS

---

## Quick Start (New Environment)

Run the following command on a fresh machine:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/masaakif/dotfiles/main/scripts/bootstrap.sh)"
```

Then restart your shell:

```
exec bash
```

# What This Does

1. Clones this repository to ~/dotfiles
2. Installs mise (if not already installed)
3. .Enables mise in .bashrc
4. Installs tools defined in .mise.toml
5. Applies dotfiles via mise run setup
6. Personal commands are located in `~/dotfiles/bin` and added to `PATH` via `.bashrc.d/path.sh`.

# Repository Structure

```
dotfiles/
├─ mise.toml                 # Tool definitions & tasks
├─ mise.local.toml.template  # template for GITHUB_TOKEN
├─ README.md                 # This file
├─ TASKS.md                  # TODOs
├─ scripts/
│   ├─ bootstrap.sh          # One-shot installer for new environments
│   ├─ setup.sh              # Apply dotfiles (symlinks / stow)
│   ├─ doctor.sh             # Environment sanity check
│   ├─ test-docker.sh        # Test with docker using local dotfiles
│   └─ test-docker-remote.sh # Test with docker using github repo
├─ bash/
│   ├─ bashrc
│   ├─ bashrc.d/
│   └─ local/share/
├─ config/
│   ├─ nvim/
│   └─ mise/
├─ git/
│   ├─ .gitconfig
│   └─ .gitconfig.local.template
└─ bin/                    # Personal CLI tools (optional)
```

# Git Configuration & Personal Information

This repository does not store personal information.

* .gitconfig (tracked)
  * Common settings only
  * Includes ~/.gitconfig.local
* .gitconfig.local (NOT tracked)
  * Contains user name / email / signing keys

# Initial setup

Then edit ~/.gitconfig.local

```
vim ~/.gitconfig.local
```

# Doctor (Environment Check)

To verify that everything is set up correctly:

```
cd ~/dotfiles
bash scripts/doctor.sh
```

This checks:

* mise installation
* required tools
* dotfiles symlinks
* git local config presence

# Installed Tools & Languages

Managed by **mise**. All tools are kept up to date (`latest` or `stable`).

### Languages
| Tool | Version | Config Path |
| :--- | :--- | :--- |
| **Rust** | `stable` | `mise/tools.common.toml` |
| **Node.js** | `latest` | `mise/tools.toml` |
| **Go** | `latest` | `mise/tools.toml` |
| **Python** | `latest` | `mise/tools.toml` |

### CLI Tools
| Tool | Version | Config Path |
| :--- | :--- | :--- |
| **Neovim** | `latest` | `mise/tools.common.toml` |
| **gh** | `latest` | `mise/tools.common.toml` |
| **ghq** | `latest` | `mise/tools.common.toml` |
| **eza** | `latest` | `mise/tools.common.toml` |
| **ripgrep** | `latest` | `mise/tools.common.toml` |
| **fzf** | `latest` | `mise/tools.common.toml` |
| **zoxide** | `latest` | `mise/tools.common.toml` |
| **tre-command** | `latest` | `mise/tools.common.toml` |
| **cargo-cache** | `latest` | `mise/tools.common.toml` |

# Notes

* Secrets, tokens, SSH keys, and GPG keys are never committed
* Machine-specific tweaks should go into local files (e.g. .bashrc.d/local.sh)
* This repo assumes bash as the default shell

# License

Public domain / MIT / Unlicensed — use freely.

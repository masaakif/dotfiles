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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/<YOUR_GH>/dotfiles/main/scripts/bootstrap.sh)"
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
├─ .mise.toml              # Tool definitions & tasks
├─ scripts/
│   ├─ bootstrap.sh        # One-shot installer for new environments
│   ├─ setup.sh            # Apply dotfiles (symlinks / stow)
│   └─ doctor.sh           # Environment sanity check
├─ bash/
│   ├─ .bashrc
│   └─ .bashrc.d/
├─ git/
│   ├─ .gitconfig
│   └─ .gitconfig.local.template
├─ vim/
│   └─ .vimrc
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

# Notes

* Secrets, tokens, SSH keys, and GPG keys are never committed
* Machine-specific tweaks should go into local files (e.g. .bashrc.d/local.sh)
* This repo assumes bash as the default shell

# License

Public domain / MIT / Unlicensed — use freely.

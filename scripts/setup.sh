#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

echo "Setting up dotfiles from: $DOTFILES_DIR"

# bash
ln -sf "$DOTFILES_DIR/bash/bashrc"   "$HOME/.bashrc"

# .bashrc.dが存在している場合は置き換える
if [ -L "$HOME/.bashrc.d" ] || [ -d "$HOME/.bashrc.d" ]; then
  rm -rf "$HOME/.bashrc.d"
fi
ln -sf "$DOTFILES_DIR/bash/bashrc.d" "$HOME/.bashrc.d"

# .local/share/bash-completion/completions が存在している場合は置き換える
if [ -L "$HOME/.local/share/bash-completion/completions" ] || [ -d "$HOME/.local/share/bash-completion/completions" ]; then
  rm -rf "$HOME/.local/share/bash-completion/completions"
fi
mkdir -p "$HOME/.local/share/bash-completion/"
ln -sf "$DOTFILES_DIR/bash/local/share/bash-completion/completions" "$HOME/.local/share/bash-completion/completions"

# git (public config)
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"

# git (local/private config)
if [ ! -e "$HOME/.gitconfig.local" ]; then
  cp "$DOTFILES_DIR/git/gitconfig.local.template" "$HOME/.gitconfig.local"
  chmod 600 "$HOME/.gitconfig.local"
  echo "Created: ~/.gitconfig.local (from template)"
else
  echo "Exists:  ~/.gitconfig.local (kept as-is)"
fi

# nvim
mkdir -p "$HOME/.config"
ln -sfn "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"

# dotfiles/bin (experimental)
if [ -d "$HOME/dotfiles/bin" ]; then
  chmod +x "$HOME/dotfiles/bin/"* 2>/dev/null || true
fi

echo "Done."
echo "Restart shell: exec bash"

#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

echo "Setting up dotfiles from: $DOTFILES_DIR"

# bash
ln -sf "$DOTFILES_DIR/bash/.bashrc"   "$HOME/.bashrc"

# .bashrc.dが存在している場合は置き換える
if [ -L "$HOME/.bashrc.d" ] || [ -d "$HOME/.bashrc.d" ]; then
  rm -rf "$HOME/.bashrc.d"
fi
ln -sf "$DOTFILES_DIR/bash/.bashrc.d" "$HOME/.bashrc.d"

# git (public config)
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# git (local/private config)
if [ ! -e "$HOME/.gitconfig.local" ]; then
  cp "$DOTFILES_DIR/git/.gitconfig.local.template" "$HOME/.gitconfig.local"
  chmod 600 "$HOME/.gitconfig.local"
  echo "Created: ~/.gitconfig.local (from template)"
else
  echo "Exists:  ~/.gitconfig.local (kept as-is)"
fi

# dotfiles/bin (experimental)
if [ -d "$HOME/dotfiles/bin" ]; then
  chmod +x "$HOME/dotfiles/bin/"* 2>/dev/null || true
fi

echo "Done."
echo "Restart shell: exec bash"

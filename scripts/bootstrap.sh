#!/usr/bin/env bash
set -e

DOTFILES_REPO="git@github.com:<YOUR_GH>/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "== dotfiles bootstrap =="

# ------------------------------------------------------------
# 1. Clone dotfiles (if not exists)
# ------------------------------------------------------------
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "dotfiles already exists: $DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# ------------------------------------------------------------
# 2. Install mise (if not exists)
# ------------------------------------------------------------
if ! command -v mise >/dev/null 2>&1; then
  echo "Installing mise..."
  curl https://mise.run | sh
else
  echo "mise already installed"
fi

# ------------------------------------------------------------
# 3. Activate mise (only if not already in shell)
# ------------------------------------------------------------
MISE_ACTIVATE_LINE='eval "$(~/.local/bin/mise activate bash)"'

if ! grep -q 'mise activate bash' "$HOME/.bashrc"; then
  echo "Enabling mise in .bashrc"
  echo "$MISE_ACTIVATE_LINE" >> "$HOME/.bashrc"
else
  echo "mise already enabled in .bashrc"
fi

# NOTE:
# Do NOT exec bash here.
# The user should restart the shell after bootstrap.

# ------------------------------------------------------------
# 4. Install tools defined in .mise.toml
# ------------------------------------------------------------
echo "Installing tools via mise..."
"$HOME/.local/bin/mise" install

# ------------------------------------------------------------
# 5. Apply dotfiles
# ------------------------------------------------------------
echo "Running mise setup task..."
"$HOME/.local/bin/mise" run setup

# ------------------------------------------------------------
# 6. Post-install message
# ------------------------------------------------------------
echo
echo "Bootstrap completed."
echo "Please restart your shell:"
echo "  exec bash"

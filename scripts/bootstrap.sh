#!/usr/bin/env bash
set -e

export MISE_YES=1
export MISE_QUIET=true
export CARGO_TERM_QUIET=true

echo "== github token = ${GITHUB_TOKEN} =="

DOTFILES_REPO="https://github.com/masaakif/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "== dotfiles bootstrap =="

# ------------------------------------------------------------
# 0. Install prerequisites (git, curl, etc.)
# ------------------------------------------------------------
DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"

if [ -f "scripts/install-deps.sh" ]; then
  echo "Found local scripts/install-deps.sh, running..."
  bash "scripts/install-deps.sh"
elif [ -f "$DOTFILES_DIR/scripts/install-deps.sh" ]; then
  echo "Found $DOTFILES_DIR/scripts/install-deps.sh, running..."
  bash "$DOTFILES_DIR/scripts/install-deps.sh"
else
  echo "Downloading and running install-deps.sh from GitHub..."
  PREREQUISITES_URL="https://raw.githubusercontent.com/masaakif/dotfiles/${DOTFILES_BRANCH}/scripts/install-deps.sh"
  curl -fsSL "$PREREQUISITES_URL" | bash
fi

# ------------------------------------------------------------
# 1. Clone dotfiles (if not exists)
# ------------------------------------------------------------
if [ ! -d "$DOTFILES_DIR" ]; then
  CLONE_ARGS=()
  if [ -n "$DOTFILES_BRANCH" ] && [ "$DOTFILES_BRANCH" != "main" ]; then
    echo "Cloning dotfiles (branch: $DOTFILES_BRANCH)..."
    CLONE_ARGS+=("-b" "$DOTFILES_BRANCH")
  else
    echo "Cloning dotfiles (default branch)..."
  fi
  git clone "${CLONE_ARGS[@]}" "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "dotfiles already exists: $DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"
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
# 4. Ensure ~/.config/mise/config.toml exists
#    If not, create it by combining common and user-specific tool configs
# ------------------------------------------------------------
mkdir -p "$HOME/.config/mise/"
if [ ! -f "$HOME/.config/mise/config.toml" ]; then
  echo "Creating ~/.config/mise/config.toml..."
  {
    echo "[tools]"
    cat config/mise/tools.common.toml config/mise/tools.toml 2>/dev/null | grep -v '^\[' || true
    echo
    cat config/mise/tasks.toml 2>/dev/null || true
  } > "$HOME/.config/mise/config.toml"
else
  echo "~/.config/mise/config.toml already exists"
fi

# ------------------------------------------------------------
# 5. Install tools defined in ~/.config/mise/config.toml
# ------------------------------------------------------------
echo "Installing tools via mise..."
"$HOME/.local/bin/mise" install

# ------------------------------------------------------------
# 6. Create $DOTFILES_DIR/.mise.toml
# ------------------------------------------------------------
echo "Creating .mise.toml..."
{
  cat "$HOME/.config/mise/config.toml"
} > "$DOTFILES_DIR/.mise.toml"

# ------------------------------------------------------------
# 6.5. Download bash-completion and 
# ------------------------------------------------------------
echo "Downloading bash-completion..."
{
  # GitHubから最新の（_comp_initializeが入っている）本体を落とす
  curl -L https://raw.githubusercontent.com/scop/bash-completion/master/bash_completion \
    -o "$DOTFILES_DIR/bash/local/share/bash-completion/completions/bash_completion"
}

# ------------------------------------------------------------
# 7. Apply dotfiles
# ------------------------------------------------------------
"$HOME/.local/bin/mise" trust "$DOTFILES_DIR/.mise.toml"
echo "Running mise setup task..."
MISE_QUIET=false "$HOME/.local/bin/mise" run setup

# ------------------------------------------------------------
# 8. Post-install message
# ------------------------------------------------------------
echo
echo "Bootstrap completed."
echo "Please restart your shell:"
echo "  exec bash"

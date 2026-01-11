#!/usr/bin/env bash
set -euo pipefail

echo "== dotfiles doctor =="

fail=0

ok()   { echo "✔ $*"; }
warn() { echo "⚠ $*"; }
ng()   { echo "✘ $*"; fail=1; }

check_cmd() {
  if command -v "$1" >/dev/null 2>&1; then ok "$1"; else ng "$1 (not found)"; fi
}

check_link_to() {
  local path="$1"
  local expected_prefix="${2:-}"

  if [ -L "$path" ]; then
    if [ -n "$expected_prefix" ]; then
      local target
      target="$(readlink -f "$path" 2>/dev/null || true)"
      if [[ "$target" == "$expected_prefix"* ]]; then
        ok "$path -> $target"
      else
        warn "$path is symlink but points elsewhere: $target"
      fi
    else
      ok "$path (symlink)"
    fi
  elif [ -e "$path" ]; then
    warn "$path exists but not symlink"
  else
    ng "$path missing"
  fi
}

check_executable() {
  if [ -x "$1" ]; then
    echo "✔ $1 (executable)"
  elif [ -e "$1" ]; then
    echo "⚠ $1 exists but is not executable"
  else
    echo "⚠ $1 (not found)"
  fi
}

echo
echo "-- commands --"
check_cmd git
check_cmd bash
check_cmd curl
check_cmd mise

echo
echo "-- mise tools --"
if command -v mise >/dev/null 2>&1; then
  if [ -f "$HOME/dotfiles/.mise.toml" ] || [ -f "$HOME/dotfiles/mise.toml" ]; then
    mise ls >/dev/null 2>&1 && ok "mise tools listed" || warn "mise tools not installed yet (run: cd ~/dotfiles && mise install)"
  else
    warn ".mise.toml not found under ~/dotfiles (is dotfiles directory different?)"
  fi
fi

echo
echo "-- dotfiles links --"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
# DOTFILES_GIT_DIR="${DOTFILES_DIR:-$HOME/dotfiles/}"
check_link_to "$HOME/.bashrc"   "$DOTFILES_DIR/"
check_link_to "$HOME/.bashrc.d" "$DOTFILES_DIR/"
check_link_to "$HOME/.gitconfig" "$DOTFILES_DIR/git/"

echo
echo "-- dotfiles bin (experimental) --"
check_executable "$HOME/dotfiles/bin/gget"

echo
echo "-- local config --"
if [ -e "$HOME/.gitconfig.local" ]; then
  ok "$HOME/.gitconfig.local"
else
  warn "$HOME/.gitconfig.local missing"
  echo "NOTE: create it from:"
  echo "  $DOTFILES_DIR/git/.gitconfig.local.template"
  echo "  cp $DOTFILES_DIR/git/.gitconfig.local.template ~/.gitconfig.local"
fi

echo
echo "-- summary --"
if [ "$fail" -eq 0 ]; then
  ok "Environment looks good."
else
  ng "Some checks failed."
  exit 1
fi


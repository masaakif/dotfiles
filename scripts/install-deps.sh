#!/usr/bin/env bash
# scripts/install-deps.sh: Install prerequisite packages for dotfiles setup
# Supports: Debian-based, RHEL-based (dnf), Arch Linux (pacman), macOS (brew)

set -euo pipefail

# Helper to run commands with sudo if available and not root
run_cmd() {
  if [ "$(id -u)" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
      sudo "$@"
    else
      echo "Error: Need root privileges or sudo to install packages." >&2
      exit 1
    fi
  else
    "$@"
  fi
}

echo "--- Installing prerequisite packages ---"

if command -v apt-get >/dev/null 2>&1; then
  echo "Debian-based system detected."
  run_cmd apt-get update -qq
  run_cmd apt-get install -qq -y --no-install-recommends \
    procps sudo curl git tzdata xz-utils unzip \
    libreadline-dev ca-certificates build-essential xclip xsel xxd >/dev/null 2>&1

elif command -v dnf >/dev/null 2>&1; then
  echo "RHEL-based system (dnf) detected."
  run_cmd dnf install -qq -y \
    procps-ng sudo curl git xz unzip \
    readline-devel ca-certificates gcc-c++ make xclip xsel xxd >/dev/null 2>&1

elif command -v pacman >/dev/null 2>&1; then
  echo "Arch Linux-based system (pacman) detected."
  run_cmd pacman -Syu --noconfirm \
    procps-ng sudo curl git xz unzip \
    readline ca-certificates base-devel xclip xsel xxd >/dev/null 2>&1

elif command -v brew >/dev/null 2>&1; then
  echo "macOS (Homebrew) detected."
  # brew is usually installed as a user, so no sudo needed.
  brew install curl git xz unzip readline
  # Note: build tools are usually provided by Xcode CLI tools (xcode-select --install)

else
  echo "Error: No supported package manager (apt, dnf, pacman, brew) found." >&2
  exit 1
fi

echo "Prerequisites installation complete."

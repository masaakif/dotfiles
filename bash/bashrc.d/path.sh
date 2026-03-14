#!/usr/bin/env bash

# ------------------------------------------------------------
# PATH settings
# ------------------------------------------------------------

# Add dotfiles bin directory
DOTFILES_BIN="$HOME/dotfiles/bin"

if [ -d "$DOTFILES_BIN" ]; then
  case ":$PATH:" in
    *":$DOTFILES_BIN:"*) ;; # already in PATH
    *) export PATH="$DOTFILES_BIN:$PATH" ;;
  esac
fi


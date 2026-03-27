#!/usr/bin/env bash

# --- History Settings ---
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoreboth
export HISTIGNORE="history"
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# neovimをデフォルトに
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=$HOME/.local/share/mise/shims/nvim

# 日本語入力(Fcitx5)の設定
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
pgrep -x "fcitx5" > /dev/null || XDG_SESSION_TYPE=x11 fcitx5 -d > /dev/null 2>&1

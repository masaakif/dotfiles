#!/usr/bin/env bash

# bash completion
if [ -f "$HOME/.local/completions/bash_completion" ]; then
    . "$HOME/.local/completions/bash_completion"
fi

# mise completion
eval "$(mise completion bash)"

# git completion
if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
fi

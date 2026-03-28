#!/usr/bin/env bash

# mise completion
eval "$(mise completion bash)"

# git completion
if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
fi

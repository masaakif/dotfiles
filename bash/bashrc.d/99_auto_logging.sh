#!/usr/bin/env bash

# --- Auto Logging (script) ---
# Only run in a top-level interactive shell attached to a TTY, 
# and not when executing a one-liner command (bash -c).
if [ -z "${SCRIPT_LOGGED:-}" ] && [[ $- == *i* ]] && [ -t 0 ] && [ -z "${BASH_EXECUTION_STRING:-}" ] && [ "${SHLVL:-1}" -lt 2 ]; then
    echo "auto logging starting..."
    mkdir -p "$HOME/terminal-logs"
    LOG_FILE="$HOME/terminal-logs/log_$(date +%Y%m%d_%H%M%S).txt"
    export SCRIPT_LOGGED=1
    exec script -q -a "$LOG_FILE"
fi

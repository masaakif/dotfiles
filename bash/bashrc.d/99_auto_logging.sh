#!/usr/bin/env bash

# --- Auto Logging (script) ---
if [ -z "$SCRIPT_LOGGED" ]; then
    echo "auto logging starting..."
    mkdir -p ~/terminal-logs
    LOG_FILE=~/terminal-logs/log_$(date +%Y%m%d_%H%M%S).txt
    export SCRIPT_LOGGED=1
    exec script -q -a "$LOG_FILE"
fi


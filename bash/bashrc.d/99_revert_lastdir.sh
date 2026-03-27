#!/usr/bin/env bash

# 前回セッション時のディレクトリを復帰
LAST_DIR_FILE="$HOME/.last_dir"

get_last_dir() {
    if [ -f "$LAST_DIR_FILE" ]; then
        cat "$LAST_DIR_FILE"
    else
	echo "$HOME"
    fi
}
save_last_dir() {
    PREV_DIR="$(get_last_dir)"
    CURRENT_DIR="$(pwd)"
    if [ "$CURRENT_DIR" != "$PREV_DIR" ]; then
       echo "$CURRENT_DIR" > "$LAST_DIR_FILE"
    fi
}
export PROMPT_COMMAND="save_last_dir; $PROMPT_COMMAND"

PREV_DIR="$(get_last_dir)"
cd "$PREV_DIR"
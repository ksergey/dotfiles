#!/bin/bash

set -e

SESSION="turboq-logger"

if ! tmux has-session -t ${SESSION} 2>/dev/null; then
    # session not exists, let's create
    tmux new-session -d -s ${SESSION} -n editor \; \
        send-keys -t ${SESSION}:editor "cd ~/dev/turboq-logger && git status" Enter \; \
        new-window -t ${SESSION} -n build \; \
        send-keys -t ${SESSION}:build "mkdir -p ~/dev/turboq-logger/debug && cd ~/dev/turboq-logger/debug" Enter \; \
        select-window -t ${SESSION}:editor
fi

tmux attach-session -t ${SESSION}

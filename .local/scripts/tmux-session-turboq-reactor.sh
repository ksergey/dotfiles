#!/bin/bash

set -e

SESSION="turboq-reactor"

if ! tmux has-session -t ${SESSION} 2>/dev/null; then
    # session not exists, let's create
    tmux new-session -d -s ${SESSION} -n editor \; \
        send-keys -t ${SESSION}:editor "cd ~/dev/turboq-reactor && git status" Enter \; \
        new-window -t ${SESSION} -n build \; \
        send-keys -t ${SESSION}:build "mkdir -p ~/dev/turboq-reactor/debug && cd ~/dev/turboq-reactor/debug" Enter \; \
        select-window -t ${SESSION}:editor
fi

tmux attach-session -t ${SESSION}

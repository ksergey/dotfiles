#!/bin/bash

set -e

SESSION="sbe-code-gen"

if ! tmux has-session -t ${SESSION} 2>/dev/null; then
    # session not exists, let's create
    tmux new-session -d -s ${SESSION} -n editor \; \
        send-keys -t ${SESSION}:editor "cd ~/dev/sbe-code-gen && git status" Enter \; \
        new-window -t ${SESSION} -n build \; \
        send-keys -t ${SESSION}:build "mkdir -p ~/dev/sbe-code-gen/debug && cd ~/dev/sbe-code-gen/debug" Enter \; \
        select-window -t ${SESSION}:editor
fi

tmux attach-session -t ${SESSION}

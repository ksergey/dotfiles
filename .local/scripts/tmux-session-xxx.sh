#!/bin/bash

set -e

SESSION="xxx"

if ! tmux has-session -t ${SESSION} 2>/dev/null; then
    # session not exists, let's create
    tmux new-session -d -s ${SESSION} -n editor \; \
        send-keys -t ${SESSION}:editor "cd ~/dev/xxx && git status" Enter \; \
        new-window -t ${SESSION} -n build \; \
        send-keys -t ${SESSION}:build "mkdir -p ~/dev/xxx/debug && cd ~/dev/xxx/debug" Enter \; \
        select-window -t ${SESSION}:editor
fi

tmux attach-session -t ${SESSION}

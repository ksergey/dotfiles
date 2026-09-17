#!/bin/bash

set -e

SESSION="turboq"

if ! tmux has-session -t ${SESSION} 2>/dev/null; then
    # session not exists, let's create
    tmux new-session -d -s ${SESSION} -n editor \; \
        send-keys -t ${SESSION}:editor "cd ~/dev/turboq && git status" Enter \; \
        new-window -t ${SESSION} -n build \; \
        send-keys -t ${SESSION}:build "mkdir -p ~/dev/turboq/debug && cd ~/dev/turboq/debug" Enter \; \
        split-window -h -p 50 -t ${SESSION}:build \; \
        send-keys -t ${SESSION}:build "mkdir -p ~/dev/turboq/release/tools && cd ~/dev/turboq/release/tools" Enter \; \
        send-keys -t ${SESSION}:build "sudo chmod 777 /dev/hugepages" Enter \; \
        send-keys -t ${SESSION}:build "taskset -c 7 ./latency_bench --role producer -t multicast -r 750000 --hugepages auto" \; \
        split-window -v -p 50 -t ${SESSION}:build \; \
        send-keys -t ${SESSION}:build "mkdir -p ~/dev/turboq/release/tools && cd ~/dev/turboq/release/tools" Enter \; \
        send-keys -t ${SESSION}:build "taskset -c 8 ./latency_bench --role consumer -t multicast --hugepages auto --drain --capacity 500" \; \
        select-window -t ${SESSION}:editor
fi

tmux attach-session -t ${SESSION}

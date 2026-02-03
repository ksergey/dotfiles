#!/bin/bash

start() {
  local file="${HOME}/Videos/Screencasts/record_$(date +%Y-%m-%d_%H-%M-%S).mp4"
  mkdir -p "$(dirname "${file}")"
  notify-send -t 2000 -a "Screen Recording" "Recording started..."
  wf-recorder -g "$(slurp)" -a -f "${file}"
}

stop() {
  pkill -SIGINT wf-recorder && notify-send -t 2000 -a "Screen Recording" "Recording stopped"
}

stop || start

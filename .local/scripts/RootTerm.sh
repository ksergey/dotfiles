#!/bin/bash

# kitty, xdotool, tmux

CLASSNAME="RootTerm"
WINDOW_ID=$(xdotool search --classname "${CLASSNAME}")

if [ -z "${WINDOW_ID}" ]; then
  nohup kitty --name="${CLASSNAME}" tmux new-session -A -s RootTerm &
else
  CURRENT_DESKTOP=$(xdotool get_desktop)
  xdotool set_desktop_for_window ${WINDOW_ID} ${CURRENT_DESKTOP}
  xdotool windowactivate ${WINDOW_ID}
  xdotool windowfocus ${WINDOW_ID}
fi


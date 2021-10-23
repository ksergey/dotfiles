#!/bin/bash

# xdotool required

CLASSNAME="RootTerm"
WINDOW_ID=$(xdotool search --classname "${CLASSNAME}")

if [ -z "${WINDOW_ID}" ]; then
  nohup kitty --name=RootTerm &
else
  CURRENT_DESKTOP=$(xdotool get_desktop)
  xdotool set_desktop_for_window ${WINDOW_ID} ${CURRENT_DESKTOP}
  xdotool windowactivate ${WINDOW_ID}
  xdotool windowfocus ${WINDOW_ID}
fi


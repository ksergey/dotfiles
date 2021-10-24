#!/bin/bash

# xprop, xdotool

DIRECTION="$1"

if [ -z "${DIRECTION}" ]; then
  exit 1
fi

WORKAREA=$(xprop -root _NET_WORKAREA)

IFS=, read WORKAREA_X WORKAREA_Y WORKAREA_WIDTH WORKAREA_HEIGHT OTHER <<< "${WORKAREA#*=}"

eval $(xdotool getactivewindow getwindowgeometry --shell --prefix WINDOW_)

case "${DIRECTION}" in
  "left")
    xdotool windowmove --sync ${WINDOW_WINDOW} ${WORKAREA_X} y
    ;;
  "right")
    xdotool windowmove --sync ${WINDOW_WINDOW} $((${WORKAREA_X} + ${WORKAREA_WIDTH} - ${WINDOW_WIDTH})) y
    ;;
  "top")
    xdotool windowmove --sync ${WINDOW_WINDOW} x ${WORKAREA_Y}
    ;;
  "bottom")
    xdotool windowmove --sync ${WINDOW_WINDOW} x $((${WORKAREA_Y} + ${WORKAREA_HEIGHT} - ${WINDOW_HEIGHT}))
    ;;
  "toggle-maximize")
    xdotool windowstate --toggle MAXIMIZED_VERT ${WINDOW_WINDOW} windowstate --toggle MAXIMIZED_HORZ ${WINDOW_WINDOW}
    ;;

esac

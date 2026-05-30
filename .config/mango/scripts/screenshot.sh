#!/bin/bash

DEST="${XDG_PICTURES_DIR:-${HOME}/Pictures}/Screenshots"
mkdir -p "${DEST}"
NAME="screenshot-$(date +%F-%H%M%S).png"
FILE="${DEST}/${NAME}"

if [ "$1" = "--full" ] || [ "$1" = "-f" ]; then
    grim - | tee "${FILE}" | wl-copy
else
    grim -g "$(slurp)" - | tee "${FILE}" | wl-copy
fi

notify-send -a "screenshot-tool" -u low -i "${FILE}" "Screenshot" "${NAME}"

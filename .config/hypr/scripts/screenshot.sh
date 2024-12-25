#!/bin/bash

set -e

saveDir="${HOME}/Pictures/Screenshots"
screenshotFn="$(date +'screenshot_%Y-%m-%d_%H%M%S.png')"
screenshotFullFn="${saveDir}/${screenshotFn}"

mkdir -p -- "${saveDir}"

case "$1" in
  "region")
    grim -g "$(slurp)" "${screenshotFullFn}"
    ;;
  *)
    grim "${screenshotFullFn}"
    ;;
esac

if wl-copy < "${screenshotFullFn}"; then
  notify-send "Screenshot" "File saved as <i>'${screenshotFullFn}'</i> and copied to the clipboard." -i "${screenshotFullFn}"
fi

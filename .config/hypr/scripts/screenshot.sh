#!/bin/bash

set -e

saveDir="${HOME}/Pictures/Screenshots"
filename="${saveDir}/$(date +'screenshot_%Y-%m-%d_%H%M%S.png')"

mkdir -p -- "${saveDir}"

case "$1" in
  "region")
    grim -g "$(slurp)" "${filename}"
    ;;
  *)
    grim "${filename}"
    ;;
esac

if wl-copy < "${filename}"; then
  notify-send "Screenshot" "File saved as <i>'${filename}'</i> and copied to the clipboard." -i "${filename}"
fi

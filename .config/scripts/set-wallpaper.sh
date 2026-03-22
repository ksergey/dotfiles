#!/usr/bin/env bash

set -e

argv0=$(basename "$0")

wallpaper="$1"
if [ -z "${wallpaper}" ]; then
    echo "usage: ${argv0} <image>"
    exit 1
fi
if [ ! -f "${wallpaper}" ]; then
    echo "file \"${wallpaper}\" not exists"
    exit 1
fi

overview="${HOME}/.cache/overview.png"

magick "${wallpaper}" -modulate 100,50 -filter Gaussian -resize 20% -blur 0x3.5 "${overview}"
if [ "${XDG_CURRENT_DESKTOP}" == "niri" ]; then
  swww img --namespace overview "${overview}"
fi

swww img \
  --transition-type wave \
  --transition-bezier ".09,.91,.52,.93" \
  --transition-step 10 \
  --transition-fps 60 \
  --transition-duration 1 \
  "${wallpaper}"

if command -v matugen &> /dev/null; then
    matugen image "${wallpaper}"
fi

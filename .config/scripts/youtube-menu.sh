#!/usr/bin/env bash

declare -A PLAYLIST=(
  ["TRAPPIN IN ＰＡＲＡＤＩＳＥ 148"]="https://www.youtube.com/watch?v=Ywq__5C9glQ"
  ["KATO feat. Jon - Turn The Lights Off"]="https://www.youtube.com/watch?v=rE_BxN7LWO4"
  [" 🔥 Vintage Soul-Funk Grooves You’ve been Wanting for | ep10 | Minimal Soul Funk Playlist "]="https://www.youtube.com/watch?v=gfPlWZ9mmxY"
)

INPUT=""
for TITLE in "${!PLAYLIST[@]}"; do
  URL="${PLAYLIST[${TITLE}]}"
  INPUT="${INPUT}${TITLE}\t${URL}\n"
done

CHOSEN=$(echo -ne "${INPUT}" | rofi -dmenu -p ">" -replace -display-columns 1 -sync)

if [ -z "${CHOSEN}" ]; then
  echo "Nothing to do"
  exit 0
fi

URL="${CHOSEN#*$'\t'}"

mpv --wayland-app-id=youtube --keepaspect-window=no "${URL}"

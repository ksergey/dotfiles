#!/bin/bash

wallpapers_dir="${HOME}/Pictures/Wallpapers"
wallpapers=( $(find "${wallpapers_dir}" -type f) )
wallpaper="${wallpapers[$RANDOM % ${#wallpapers[@]}]}"
wallpaper_overview="${HOME}/.cache/wallpaper-overview.png"

swww img \
  --transition-type wave \
  --transition-step 10 \
  --transition-fps 60 \
  --transition-duration 1 \
  "${wallpaper}"

magick ${wallpaper} -modulate 60,105 -filter Gaussian -resize 20% -blur 0x3.5 "${wallpaper_overview}"

if [ "${XDG_CURRENT_DESKTOP}" == "niri" ]; then
  swww img --namespace overview "${wallpaper_overview}"
fi

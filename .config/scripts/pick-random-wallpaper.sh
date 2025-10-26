#!/bin/bash

wallpapersDir=${HOME}/Pictures/Wallpapers
wallpapers=( $(find "${wallpapersDir}" -type f) )
wallpaper=${wallpapers[$RANDOM % ${#wallpapers[@]}]}

swww img \
  --transition-type wave \
  --transition-step 10 \
  --transition-fps 60 \
  --transition-duration 1 \
  "${wallpaper}"

#!/bin/bash

wallpapersDir=${HOME}/Pictures/Wallpapers
wallpaper=$(find "${wallpapersDir}" -type f | shuf -n 1)

swww img \
  --transition-type wave \
  --transition-step 10 \
  --transition-fps 60 \
  --transition-duration 1 \
  "${wallpaper}"

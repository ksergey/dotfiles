#!/bin/bash

wallpapersDir=${HOME}/Pictures/Wallpapers
wallpaperFile=$(find "${wallpapersDir}" -type f | shuf -n 1)

swww img "${wallpaperFile}"

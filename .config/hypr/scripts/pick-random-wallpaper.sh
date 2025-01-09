#!/bin/bash

wallpapersDir=${HOME}/Pictures/Wallpapers
wallpaper=$(find "${wallpapersDir}" -type f | shuf -n 1)

swww img "${wallpaper}"

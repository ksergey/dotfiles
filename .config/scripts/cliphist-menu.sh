#!/usr/bin/env bash

case $1 in
  d)
    cliphist list | rofi -dmenu -p ">" -replace -display-columns 2 -sync | cliphist delete
    ;;

  w)
    if [ $(echo -e "Clear\nCancel" | rofi -dmenu -p ">" -sync) == "Clear" ]; then
      cliphist wipe
    fi
    ;;

  *)
    cliphist list | rofi -dmenu -p ">" -replace -display-columns 2 -sync | cliphist decode | wl-copy
    ;;
esac

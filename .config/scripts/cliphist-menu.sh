#!/usr/bin/env bash

case $1 in
  d)
    cliphist list | rofi -dmenu -replace -config ~/.config/rofi/cliphist.rasi -display-columns 2 -sync | cliphist delete
    ;;

  w)
    if [ $(echo -e "Clear\nCancel" | rofi -dmenu -config ~/.config/rofi/cliphist.rasi -sync) == "Clear" ]; then
      cliphist wipe
    fi
    ;;

  *)
    cliphist list | rofi -dmenu -replace -config ~/.config/rofi/cliphist.rasi -display-columns 2 -sync | cliphist decode | wl-copy
    ;;
esac

#!/usr/bin/env bash

kitty \
  --override confirm_os_window_close=0 \
  --override background_image=~/.config/kitty/cava.png \
  --override background_image_layout=centered \
  --app-id cava \
  --class cava \
  --title cava \
  -e cava

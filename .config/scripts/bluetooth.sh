#!/usr/bin/env bash

kitty \
  --override confirm_os_window_close=0 \
  --override background_image=~/.config/kitty/network.png \
  --class wifi \
  -e bluetui

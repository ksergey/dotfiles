#!/usr/bin/env bash

# generate colors
rong image $(swww query | sed 's/^.*image:\ //')

# reload kitty
killall -0 kitty && killall -USR1 kitty

# reload tmux
tmux source-file ~/.tmux.conf

# reload cava
killall -0 cava && killall -USR1 cava

# niri
~/.config/rong/update-niri.sh

# waybar
killall -0 waybar && killall -USR2 waybar

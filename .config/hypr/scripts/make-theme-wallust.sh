#!/usr/bin/env bash

wallust run $(swww query | sed 's/^.*image:\ //')

# reload waybar
killall -q -SIGUSR2 waybar || true

# reload hyprland
hyprctl reload

# reload cava
killall -q -SIGUSR1 cava || true

# reload kitty
killall -q -SIGUSR1 kitty || true

# reload dunstrc
killall -q dunst; hyprctl dispatch exec dunst && notify-send "updated"

# reload tmux
tmux source-file ~/.tmux.conf

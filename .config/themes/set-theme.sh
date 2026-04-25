#!/bin/bash

themesRoot="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

theme="$1"
if [ -z "${theme}" ]; then
    echo "Theme not selected"
    exit 1
fi

themeRoot="${themesRoot}/${theme}"
if [ ! -d "${themeRoot}" ]; then
    echo "Theme \"${theme}\" not found"
    exit 1
fi

# cava
if [ -f "${themeRoot}/cava-theme" ]; then
    echo "Updating cava"
    cp "${themeRoot}/cava-theme" "${HOME}/.config/cava/config"
    pkill -SIGUSR1 cava
fi

# niri
if [ -f "${themeRoot}/niri-theme.kdl" ]; then
    echo "Updating niri"
    cp "${themeRoot}/niri-theme.kdl" "${HOME}/.config/niri/theme.kdl"
fi

# kitty
if [ -f "${themeRoot}/kitty-theme.conf" ]; then
    echo "Updating kitty"
    cp "${themeRoot}/kitty-theme.conf" "${HOME}/.config/kitty/theme.conf"
    pkill -USR1 kitty
fi

# rofi
if [ -f "${themeRoot}/rofi-theme.rasi" ]; then
    echo "Updating rofi"
    cp "${themeRoot}/rofi-theme.rasi" "${HOME}/.config/rofi/theme.rasi"
fi

# tmux
if [ -f "${themeRoot}/tmux-theme.conf" ]; then
    echo "Updating tmux"
    cp "${themeRoot}/tmux-theme.conf" "${HOME}/.config/tmux/theme.conf"
    if tmux -q has-session &>/dev/null; then
        tmux source ~/.config/tmux/tmux.conf
    fi
fi

# waybar
if [ -f "${themeRoot}/waybar-theme.css" ]; then
    echo "Updating waybar"
    cp "${themeRoot}/waybar-theme.css" "${HOME}/.config/waybar/theme.css"
    pkill -SIGUSR2 waybar
fi

# dunst
if [ -f "${themeRoot}/dunst-theme" ]; then
    echo "Updating dunst"
    cp "${themeRoot}/dunst-theme" "${HOME}/.config/dunst/dunstrc"
    dunstctl reload
fi

notify-send "theme updated"

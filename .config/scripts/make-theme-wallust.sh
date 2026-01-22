#!/usr/bin/env bash

WALLPAPER=$1

spawn() {
  case "${XDG_CURRENT_DESKTOP}" in
    niri)
      niri msg action spawn -- $*
      ;;
    Hyprland)
      hyprctl dispatch exec $*
  esac
}

update_gtk() {
  gsettings set org.gnome.desktop.interface gtk-theme ""
  sleep 0.5s
  gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
}

update_dunst() {
  pidof dunst | xargs -r kill
  spawn dunst
}

post_hook() {
  # reload kitty
  pidof kitty | xargs -r kill -USR1

  # reload tmux
  tmux source-file ~/.tmux.conf

  # reload cava
  pidof cava | xargs -r kill -USR1

  # gtk3
  # update_gtk

  # waybar
  pidof waybar | xargs -r kill -USR2

  # dunst
  update_dunst
}

if [ -z "${WALLPAPER}" ]; then
  WALLPAPER=$(swww query | sed 's/^.*image:\ //')
fi

if [ -z "${WALLPAPER}" ]; then
  echo "ERROR: wallpaper not found"
  exit 1
fi

# generate colors
wallust run "${WALLPAPER}"

post_hook

notify-send 'Theme applied'

#!/usr/bin/env bash

SCHEME="$1"

spawn() {
  case "${XDG_CURRENT_DESKTOP}" in
    niri)
      niri msg action spawn -- $*
      ;;
    Hyprland)
      hyprctl dispatch exec $*
  esac
}

update_niri() {
  local PATCH="${HOME}/.config/niri/colors.kdl"
  local CONFIG="${HOME}/.config/niri/config.kdl"

  if [ ! -f "${PATCH}" ] || [ ! -f "${CONFIG}" ]; then
    echo "nothing to update"
    return
  fi

  local ACTIVE_COLOR=$(sed -n 's/.*\ active-color\ \(.*\)/\1/p ' < "${PATCH}")
  local INACTIVE_COLOR=$(sed -n 's/.*\ inactive-color\ \(.*\)/\1/p ' < "${PATCH}")

  sed -i "s/\(^ *active-color\)\(.*\)$/\1 ${ACTIVE_COLOR}/" "${CONFIG}"
  sed -i "s/\(^ *inactive-color\)\(.*\)$/\1 ${INACTIVE_COLOR}/" "${CONFIG}"
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

  # niri
  update_niri

  # gtk3
  update_gtk

  # waybar
  pidof waybar | xargs -r kill -USR2

  # dunst
  update_dunst
}

if [ -z "${SCHEME}" ]; then
  echo "usage: $(basename ${BASH_SOURCE[0]}) <theme url>"
  exit 1
fi

# generate colors
walng --theme "${SCHEME}"

post_hook

notify-send 'Theme applied'

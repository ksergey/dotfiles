#!/usr/bin/env bash

src="${HOME}/.config"
dest="$(realpath $(dirname $0))/.config"

entities=(
  FreeCAD
  cava/config
  dunst
  fastfetch
  hypr
  kitty
  matugen
  rofi
  walng
  waybar
  wallust
  yt-dlp
  mpv
  locale.conf
  user-dirs.dirs
  user-dirs.locale
)

for entity in ${entities[@]}; do
  echo "<${entity}>"

  if [[ -e "${dest}/${entity}" ]]; then
    echo " * removing dest..."
    rm -r "${dest}/${entity}"
  fi

  echo " * copying to dest..."
  cp -r "${src}/${entity}" "${dest}/${entity}"
done

echo " * dumping installed packages list"
mkdir -p arch
pacman -Qqen > arch/pkglist.txt
pacman -Qqem > arch/aurlist.txt

git add arch .config

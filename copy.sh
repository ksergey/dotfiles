#!/usr/bin/env bash

C_RED="\e[0;31;1m"
C_GREEN="\e[0;32;1m"
C_CYAN="\e[0;36;1m"
C_RESET="\e[0m"

# script path
DEST="$(realpath $(dirname $0))"

ENTRIES=(
  "${HOME}/.config/FreeCAD"
  "${HOME}/.config/cava/config"
  "${HOME}/.config/dunst"
  "${HOME}/.config/fastfetch"
  "${HOME}/.config/hypr"
  "${HOME}/.config/kitty"
  "${HOME}/.config/matugen"
  "${HOME}/.config/rofi"
  "${HOME}/.config/niri"
  "${HOME}/.config/walng"
  "${HOME}/.config/waybar"
  "${HOME}/.config/wallust"
  "${HOME}/.config/yt-dlp"
  "${HOME}/.config/mpv"
  "${HOME}/.config/scripts"
  "${HOME}/.config/locale.conf"
  "${HOME}/.config/user-dirs.dirs"
  "${HOME}/.config/user-dirs.locale"
  "${HOME}/.config/fish/config.fish"
  "${HOME}/.local/share/applications/Heroes3HotA-launcher.desktop"
  "${HOME}/.local/share/applications/Heroes3HotA.desktop"
  "${HOME}/.local/share/applications/OrcaSlicer.desktop"
)

# prefix_length -> length of $HOME + length of /
PREFIX_LENGTH=$(expr ${#HOME} + 1)

for ENTRY_SRC in ${ENTRIES[@]}; do
  ENTRY_DST="${DEST}/${ENTRY_SRC:$PREFIX_LENGTH}"

  if [[ "${HOME}/" != "${ENTRY_SRC:0:$PREFIX_LENGTH}" ]]; then
    printf "skipping ${ENTRY_SRC}\n"
    continue
  fi

  if [[ -e "${ENTRY_DST}" ]]; then
    printf " * removing %b%s%b\n" "${C_RED}" "${ENTRY_DST}" "${C_RESET}"
    rm -r "${ENTRY_DST}"
  fi

  # create dst dir if not exists
  ENTRY_DST_DIR="$(dirname "${ENTRY_DST}")"
  mkdir -p "${ENTRY_DST_DIR}"

  printf " * copying %s -> %b%s%b\n" "${ENTRY_SRC}" "${C_GREEN}" "${ENTRY_DST}" "${C_RESET}"
  cp -r "${ENTRY_SRC}" "${ENTRY_DST}"
done

# echo " * dumping installed packages list"
printf " * %bdumping installed packages list%b\n" "${C_CYAN}" "${C_RESET}"
mkdir -p arch
pacman -Qqen > arch/pkglist.txt
pacman -Qqem > arch/aurlist.txt

git add arch .config

#!/usr/bin/env bash

set -e

C_RED="\e[0;31;1m"
C_GREEN="\e[0;32;1m"
C_CYAN="\e[0;36;1m"
C_RESET="\e[0m"

# script path
GIT_HOME="$(realpath $(dirname $0))"

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
  "${HOME}/.config/rong"
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
  "${HOME}/.config/gtk-3.0"
  "${HOME}/.config/gtk-4.0"
  "/etc/iwd/main.conf"
  "/etc/sysctl.d/99_default_ttl.conf"
  "/etc/systemd/logind.conf"
)

# prefix_length -> length of $HOME + length of /
HOME_PREFIX_LENGTH=$(expr ${#HOME} + 1)

function starts_with() {
  [[ "$1" == "$2"* ]]
}

function remove_home_prefix() {
  local STR="$1"
  echo "${STR##${HOME}/}"
}

for ENTRY_SRC in ${ENTRIES[@]}; do
  ENTRY_SRC="${ENTRY_SRC/#\~/$HOME}"

  if starts_with "${ENTRY_SRC}" "${HOME}"; then
    ENTRY_DST="${GIT_HOME}/$(remove_home_prefix "${ENTRY_SRC}")"
  elif starts_with "${ENTRY_SRC}" "/"; then
    ENTRY_DST="${GIT_HOME}/system${ENTRY_SRC}"
  else
    printf " * skiping entry \"%s\": %b%s%b\n" "${ENTRY_SRC}" "${C_RED}" "relative path" "${C_RESET}"
    continue
  fi

  if [ ! -e "${ENTRY_SRC}" ]; then
    printf " * skiping entry \"%s\": %b%s%b\n" "${ENTRY_SRC}" "${C_RED}" "not found" "${C_RESET}"
    continue
  fi

  printf " * source: %b\"%s\"%b\n" "${C_GREEN}" "${ENTRY_SRC}" "${C_RESET}"
  printf "   dest:   %b\"%s\"%b\n" "${C_CYAN}" "${ENTRY_DST}" "${C_RESET}"

  if [[ -e "${ENTRY_DST}" ]]; then
    printf "     removing previous version from dst\n"
    rm -r "${ENTRY_DST}"
  fi

  # create dst dir if not exists
  ENTRY_DST_DIR="$(dirname "${ENTRY_DST}")"
  mkdir -p "${ENTRY_DST_DIR}"

  printf "     copying to dst\n"
  cp -r "${ENTRY_SRC}" "${ENTRY_DST}"
done

printf " * %bdumping installed packages list%b\n" "${C_CYAN}" "${C_RESET}"
mkdir -p "${GIT_HOME}/arch"
pacman -Qqen > "${GIT_HOME}/arch/pkglist.txt"
pacman -Qqem > "${GIT_HOME}/arch/aurlist.txt"

git add ${GIT_HOME}/{arch,.config,system}

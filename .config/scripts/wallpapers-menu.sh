#!/usr/bin/env bash

wallpapers_dir="${HOME}/Pictures/Wallpapers"
wallpapers=( $(find "${wallpapers_dir}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \)) )

# Set some variables
script_dir=$(dirname "$(realpath "$0")")
cache_dir="${HOME}/.cache/wallpapers-menu"

# Create cache dir if not exists
mkdir -p "${cache_dir}"

input=""
for wallpaper in "${wallpapers[@]}"; do
  filename=$(basename "${wallpaper}")
  cache_file="${cache_dir}/${filename}"
  if [ ! -f "${cache_file}" ]; then
    echo "make cache for wallpaper ${wallpaper} -> $cache_file"
    magick "${wallpaper}" -resize 500x500^ -gravity center -extent 500x500 "${cache_file}"
  fi

  if [ ! -z "${input}" ]; then
    input="${input}\n"
  fi
  input="${input}${wallpaper}\0icon\x1f${cache_file}"
done

rofi_cmd() {
	rofi -dmenu -theme "$HOME/.config/rofi/wallpapers-menu.rasi" -sync
}

wallpaper=$(echo -e "${input}" | rofi_cmd)

if [ ! -f "${wallpaper}" ]; then
  exit 1
fi

if command -v gowall &> /dev/null; then
  wallpaper_gowall="${HOME}/.cache/wallpaper-gowall-processed.png"
  # gowall convert "${wallpaper}" -t tokyo-dark --output "${wallpaper_gowall}"
  # wallpaper="${wallpaper_gowall}"
fi

swww img \
  --transition-type wave \
  --transition-bezier ".09,.91,.52,.93" \
  --transition-step 10 \
  --transition-fps 60 \
  --transition-duration 1 \
  "${wallpaper}"

wallpaper_overview="${HOME}/.cache/wallpaper-overview.png"

magick "${wallpaper}" -modulate 100,50 -filter Gaussian -resize 20% -blur 0x3.5 "${wallpaper_overview}"

if [ "${XDG_CURRENT_DESKTOP}" == "niri" ]; then
  swww img --namespace overview "${wallpaper_overview}"
fi

if [ -f "${script_dir}/make-theme-rong.sh" ]; then
  ${script_dir}/make-theme-rong.sh
elif [ -f "${script_dir}/make-theme-matugen.sh" ]; then
  ${script_dir}/make-theme-matugen.sh
fi

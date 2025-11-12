#!/usr/bin/env bash

colors_file="${HOME}/.config/niri/colors.kdl"
config_file="${HOME}/.config/niri/config.kdl"

if [ ! -f "${colors_file}" ] || [ ! -f "${config_file}" ]; then
  exit 1;
fi

# obtain theme colors
active_color=$(sed -n 's/.*\ active-color\ \(.*\)/\1/p ' < "${colors_file}")
inactive_color=$(sed -n 's/.*\ inactive-color\ \(.*\)/\1/p ' < "${colors_file}")

# replace colors in config
sed -i "s/\(^ *active-color\)\(.*\)$/\1 ${active_color}/" "${config_file}"
sed -i "s/\(^ *inactive-color\)\(.*\)$/\1 ${inactive_color}/" "${config_file}"

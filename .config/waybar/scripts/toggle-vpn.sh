#!/usr/bin/env bash

amneziaConfig="${1}"
app="Network Manager"
icon="network-wireless-symbolic"

if [ ! -f "${amneziaConfig}" ]; then
  notify-send "AmneziaWG config not set or not exists" --app-name="${app}" --icon="${icon}" -u low
  exit 1
fi

interface=$(basename "${amneziaConfig}" ".conf")

if [ -e "/sys/class/net/${interface}" ]; then
   awg-quick down "${amneziaConfig}"
   # notify-send "AmneziaWG Down" --app-name="${app}" --icon="${icon}" -u low
else
   awg-quick up "${amneziaConfig}"
   # notify-send "AmneziaWG Up" --app-name="${app}" --icon="${icon}" -u low
fi

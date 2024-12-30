#!/usr/bin/env bash

amneziaConfig="${1}"
notificationIcon="network-wired-symbolic"

if [ ! -f "${amneziaConfig}" ]; then
  notify-send "AmneziaWG config not set or not exists" --app-name Settings --icon="${notificationIcon}"
  exit 1
fi

interface=$(basename "${amneziaConfig}" ".conf")

echo $interface

if [ -e "/sys/class/net/${interface}" ]; then
   awg-quick down "${amneziaConfig}"
   notify-send "AmneziaWG Down" --app-name Settings --icon="${notificationIcon}"
else
   awg-quick up "${amneziaConfig}"
   notify-send "AmneziaWG Up" --app-name Settings --icon="${notificationIcon}"
fi

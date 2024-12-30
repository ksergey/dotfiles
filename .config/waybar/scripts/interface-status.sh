#!/usr/bin/env bash

set -euo pipefail

interface="${1:-amnezia_for_awg}"

function updateInterfaceStatus() {
  if [ -e "/sys/class/net/${interface}" ]; then
    class="up"
    text="interface up"
  else
    class="down"
    text="interface down"
  fi

  printf '{"text": "%s", "alt": "%s", "class": "%s"}\n' "${text}" "${class}" "${class}"
}

# kill all child processes
trap 'kill $(jobs -p) &> /dev/null' EXIT

updateInterfaceStatus

ip monitor link | while read -r line; do
  updateInterfaceStatus
done

#!/usr/bin/env bash

amneziaConfig="${1}"

if [ ! -f "${amneziaConfig}" ]; then
  echo "amnezia vpn config not found"
  exit 1
fi

interface=$(basename "${amneziaConfig}" ".conf")

echo $interface

# if [ -e "/sys/class/net/${interface}" ]; then

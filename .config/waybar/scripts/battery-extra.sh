#!/usr/bin/env bash

upower -i /org/freedesktop/UPower/devices/battery_BAT0 | \
	awk '/energy-full:/ {ef=$2} /energy-full-design:/ {efd=$2} END {printf "{\"text\": \"%.0f\"}\n", (1.0 - ef/efd) * 100}'

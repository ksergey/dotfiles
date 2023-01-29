#!/bin/bash

iconPresentationModeEnabled="face-cool-symbolic"
iconPresentationModeDisabled="face-plain-symbolic"
expireTime=3000

# toggle
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T

# fetch state
enabled=$(xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -v)

if [ "${enabled}" == "true" ]; then
	notify-send "Presentation" "enabled" --icon="${iconPresentationModeEnabled}" --expire-time=${expireTime}
else
	notify-send "Presentation" "disabled" --icon="${iconPresentationModeDisabled}" --expire-time=${expireTime}
fi

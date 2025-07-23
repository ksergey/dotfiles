#!/usr/bin/env bash

# Options
shutdown='󰐥 Shutdown'
reboot='󰜉 Reboot'
lock='󰌾 Lock'
suspend='󰤄 Suspend'
logout='󰍃 Logout'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu -theme "$HOME/.config/rofi/powermenu.rasi"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
	$shutdown)
		systemctl poweroff
		;;
	$reboot)
		systemctl reboot
		;;
	$lock)
		hyprlock
		;;
	$suspend)
		systemctl suspend
		;;
	$logout)
    hyprctl dispatch exit
		;;
esac

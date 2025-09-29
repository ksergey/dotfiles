#!/usr/bin/env bash

# Options
lock='Lock'
suspend='Suspend'
logout='Logout'
reboot='Reboot'
shutdown='Shutdown'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu -theme "$HOME/.config/rofi/powermenu.rasi" -sync
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

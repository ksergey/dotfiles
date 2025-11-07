#!/usr/bin/env bash

all=(Lock Suspend Logout Reboot Shutdown)

declare -A icons=(
	[Lock]=${HOME}/.config/rofi/icons/lock.png
	[Suspend]=${HOME}/.config/rofi/icons/sleep.png
	[Logout]=${HOME}/.config/rofi/icons/logout.png
	[Reboot]=${HOME}/.config/rofi/icons/restart.png
	[Shutdown]=${HOME}/.config/rofi/icons/power.png
)

for entry in ${all[@]}; do
	icon="${icons[$entry]}"
	if [ ! -z "${input}" ]; then
		input="${input}\n"
	fi
	input="${input}${entry}\0icon\x1f${icon}"
done

# Rofi CMD
rofi_cmd() {
	rofi -dmenu -theme "$HOME/.config/rofi/power-menu.rasi" -sync -show-icons
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "${input}" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
	Lock)
		hyprlock
		;;
	Suspend)
		systemctl suspend
		;;
	Logout)
		case "${XDG_CURRENT_DESKTOP}" in
			niri)
				niri msg action quit
				;;
			Hyprland)
				hyprctl dispatch exit
		esac
		;;
	Reboot)
		systemctl reboot
		;;
	Shutdown)
		systemctl poweroff
		;;
esac

#!/usr/bin/env bash

declare -A entries=(
	[lock]='Lock'
	[suspend]='Suspend'
	[logout]='Logout'
	[reboot]='Reboot'
	[shutdown]='Shutdown'
)

declare -A icons=(
	[lock]=${HOME}/.config/rofi/icons/lock.png
	[suspend]=${HOME}/.config/rofi/icons/sleep.png
	[logout]=${HOME}/.config/rofi/icons/logout.png
	[reboot]=${HOME}/.config/rofi/icons/restart.png
	[shutdown]=${HOME}/.config/rofi/icons/power.png
)

for entry in "${!entries[@]}"; do
	if [ ! -z "${input}" ]; then
		input="${input}\n"
	fi
	input="${input}${entries[$entry]}\0icon\x1f${icons[$entry]}"
done

# Rofi CMD
rofi_cmd() {
	rofi -dmenu -theme "$HOME/.config/rofi/powermenu.rasi" -sync -show-icons
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "${input}" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
	${entries[lock]})
		hyprlock
		;;
	${entries[suspend]})
		systemctl suspend
		;;
	${entries[logout]})
		case "${XDG_CURRENT_DESKTOP}" in
			niri)
				niri msg action quit
				;;
			hyprland)
				hyprctl dispatch exit
		esac
		;;
	${entries[reboot]})
		systemctl reboot
		;;
	${entries[shutdown]})
		systemctl poweroff
		;;
esac

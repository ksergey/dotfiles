#!/usr/bin/env bash

all=(Lock Suspend Logout Reboot Shutdown)

for entry in ${all[@]}; do
	input="${input}${entry}\n"
done

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "${input}" | rofi -dmenu -theme "$HOME/.config/rofi/power-menu.rasi"
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
        loginctl terminate-user "${USER}"
		;;
	Reboot)
		systemctl reboot
		;;
	Shutdown)
		systemctl poweroff
		;;
esac

#!/usr/bin/env bash

notificationIcon="network-wireless-symbolic"

# Notify the user that the script is running
notify-send "Getting list of available Wi-Fi networks..." --app-name Settings --icon="${notificationIcon}"

# Get a list of available Wi-Fi connections and format it
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

# Check if Wi-Fi is enabled or disabled
connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
    toggle="󰖪  Disable Wi-Fi"
else
    toggle="󰖩  Enable Wi-Fi"
fi

# Use wofi to select Wi-Fi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | wofi --show dmenu -i --prompt "Wi-Fi SSID: ")

# Get the name of the chosen connection
read -r chosen_id <<< "${chosen_network:3}"

if [ -z "$chosen_network" ]; then
    exit
elif [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
    nmcli radio wifi on
    notify-send "Wi-Fi Status" "Wi-Fi enabled." --app-name Settings --icon="${notificationIcon}"
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
    nmcli radio wifi off
    notify-send "Wi-Fi Status" "Wi-Fi disabled." --app-name Settings --icon="${notificationIcon}"
else
    # Message to show when connection is activated successfully
    success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."

    # Get saved connections
    saved_connections=$(nmcli -g NAME connection)
    if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
        nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
    else
        if [[ "$chosen_network" =~ "" ]]; then
            wifi_password=$(wofi --show dmenu -i --prompt "Password: " --password)
        fi

        # Attempt to connect to the selected Wi-Fi network
        if nmcli device wifi connect "$chosen_id" password "$wifi_password"; then
            notify-send "Connection Established" "$success_message" --app-name Settings --icon="${notificationIcon}"
        else
            notify-send "Connection Failed" "Could not connect to \"$chosen_id\". Please check your password or network." --app-name Settings --icon="${notificationIcon}"
        fi
    fi
fi


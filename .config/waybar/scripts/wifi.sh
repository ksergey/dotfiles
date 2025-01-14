#!/usr/bin/env bash

app="Network Manager"
icon="network-wireless-symbolic"

# Notify the user that the script is running
notify-send "Getting list of available Wi-Fi networks..." --app-name="${app}" --icon="${icon}" -u low

# Get a list of available Wi-Fi connections and format it
wifiList=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

# Check if Wi-Fi is enabled or disabled
connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
    toggle="󰖪  Disable Wi-Fi"
else
    toggle="󰖩  Enable Wi-Fi"
fi

# Use wofi to select Wi-Fi network
chosenNetwork=$(echo -e "$toggle\n$wifiList" | uniq -u | wofi --show dmenu -i --prompt "Wi-Fi SSID: ")

# Get the name of the chosen connection
read -r chosenId <<< "${chosenNetwork:3}"

if [ -z "$chosenNetwork" ]; then
    exit
elif [ "$chosenNetwork" = "󰖩  Enable Wi-Fi" ]; then
    nmcli radio wifi on
    notify-send "Wi-Fi Status" "Wi-Fi enabled." --app-name="${app}" --icon="${icon}" -u low
elif [ "$chosenNetwork" = "󰖪  Disable Wi-Fi" ]; then
    nmcli radio wifi off
    notify-send "Wi-Fi Status" "Wi-Fi disabled." --app-name="${app}" --icon="${icon}" -u low
else
    # Message to show when connection is activated successfully
    successMessage="You are now connected to the Wi-Fi network \"$chosenId\"."

    # Get saved connections
    savedConnections=$(nmcli -g NAME connection)
    if [[ $(echo "$savedConnections" | grep -w "$chosenId") = "$chosenId" ]]; then
        nmcli connection up id "$chosenId" | grep "successfully" && notify-send "Connection Established" "$successMessage" -u low
    else
        if [[ "$chosenNetwork" =~ "" ]]; then
            wifiPassword=$(wofi --show dmenu -i --prompt "Password: " --password)
        fi

        # Attempt to connect to the selected Wi-Fi network
        if nmcli device wifi connect "$chosenId" password "$wifiPassword"; then
            notify-send "Connection Established" "$successMessage" --app-name="${app}" --icon="${icon}" -u low
        else
            notify-send "Connection Failed" "Could not connect to \"$chosenId\". Please check your password or network." --app-name="${app}" --icon="${icon}" -u low
        fi
    fi
fi


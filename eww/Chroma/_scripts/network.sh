#! /bin/bash

ssid="$(iwgetid -r)"

function net_status()
{
    if [[ -z "${ssid}" ]]; then
        echo "Disconnected"
    else
        echo "Connected"
    fi
}

function net_toggle()
{
    if [[ -z "${ssid}" ]]; then
        nmcli con up ifname "$(/usr/bin/ls /sys/class/ieee80211/*/device/net/)"
    else
        nmcli con down id "${ssid}"
    fi
}

case "${1}" in
    "--status") net_status ;;
    "--toggle") net_toggle ;;
esac

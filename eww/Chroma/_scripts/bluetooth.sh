#! /bin/bash

state="$(bluetoothctl show | grep 'Powered' | awk '{ print $2 }')"

function get_status()
{
    if [[ "${state}" == "yes" ]]; then
        echo "Active"
    else
        echo "Inactive"
    fi
}

function bt_toggle()
{
    if [[ "$(get_status)" == "Active" ]]; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
}

case "${1}" in
    "--status") get_status ;;
    "--toggle") bt_toggle ;;
esac

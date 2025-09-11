#! /bin/bash

SINK="$(pactl list short sinks | grep 'RUNNING' | awk '{ print $1}')"

function is_muted()
{
    state="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

    if echo "${state}" | grep -q '\bMUTED\b'; then
        echo "Muted"
    else
        echo "Active"
    fi
}

function get_volume()
{
    volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F ' ' '{ print $2 }')"
    echo "${volume//0./}"
}

function set_volume()
{
    pactl set-sink-volume @DEFAULT_SINK@ "${1}%"
}

case "${1}" in
    "--toggle") wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    "--is_muted") is_muted ;;
    "--get_volume") get_volume ;;
    "--set") set_volume "${2}";;
esac

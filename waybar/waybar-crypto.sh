#!/usr/bin/env bash

source "${HOME}/.cache/wal/colors.sh"

content="$(waybar-crypto)"

filter="$(echo "${content}" | jq -r '.text')"

if [[ "${filter}" == *-* ]]; then
    echo "<span foreground=\"${color1}\">${filter}</span>"
elif [[ "${filter}" == *+* ]]; then
    echo "<span foreground=\"${color2}\">${filter}</span>"
else
    echo "<span foreground=\"${foreground}\">${filter}</span>"
fi

#!/usr/bin/env bash

if [[ ! "$(pgrep eww)" ]]; then
    eww -c "${HOME}/.config/eww/Chroma" daemon
    eww -c "${HOME}/.config/eww/Chroma" open top_bar
    eww -c "${HOME}/.config/eww/Chroma" open info_dashboard
fi


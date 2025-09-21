#!/usr/bin/env bash

if [[ ! "$(pgrep eww)" ]]; then
    eww -c "${HOME}/.config/eww/Chroma" daemon
    eww -c "${HOME}/.config/eww/Chroma" open-many top_bar info_dashboard
fi


#! /bin/bash

STATUS="$(playerctl -p 'spotify' status)"

function get_status()
{
    case "${STATUS}" in 
        "Playing") echo " " ;;
        "Paused") echo " " ;;
        *) echo "" ;;
    esac
}

function get_song()
{
    playerctl -p 'spotify' --follow metadata --format "{{ trunc(title, 30) }}"
}

function get_artist()
{
    artist="$(playerctl -p 'spotify' metadata --format "{{ artist }}")"

    if [[ "${artist}" == "No players found" ]]; then
        echo ""
    else
        echo "${artist}"
    fi
}

function get_album()
{
    playerctl -p spotify --follow metadata --format "{{ trunc(album, 55) }}"
}

function get_time()
{
    playerctl -p 'spotify' --follow metadata --format "{{ duration(position) }}"
}

function get_ttime()
{
    playerctl -p 'spotify' --follow metadata --format "{{ duration(mpris:length) }}"
}

function get_cover()
{
    # cover_url="$(playerctl -p 'spotify' metadata --format "{{ mpris:artUrl }}")"
    # current_cover="$(cat "/tmp/playerctl-cover-url")"

    # echo "${cover_url} || ${current_cover}"

    # if [[ "${current_cover}" == "${cover_url}" ]]; then
        # return
    # fi

    # echo "${cover_url}" > "/tmp/playerctl-cover-url"

    # wget "${cover_url}" -O "${HOME}/.config/eww/Chroma/assets/music/current.jpeg"

    # if [[ "${cover_url}" == "No players found" ]]; then
    #     echo ""
    # else
    #     echo "${HOME}/.config/eww/Chroma/assets/music/current.jpeg"
    # fi
    playerctl -p 'spotify' --follow metadata --format "{{ mpris:artUrl }}"
}

function toggle_music()
{
    playerctl -p 'spotify' play-pause 1> "/dev/null" 2>&1
}

function play_next()
{
    playerctl -p 'spotify' next
}

function play_previous()
{
    playerctl -p 'spotify' previous
}

case "$1" in
    "--song") get_song ;;
    "--artist") get_artist ;;
    "--album") get_album ;;
    "--status") get_status ;;
    "--time") get_time ;;
    "--ttime") get_ttime ;;
    "--cover") get_cover ;;
    "--toggle") toggle_music ;;
    "--next") play_next ;;
    "--prev") play_previous ;;
esac

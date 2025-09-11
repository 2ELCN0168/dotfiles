#! /bin/bash

EWW_CMD="eww -c /home/eluciani/.config/eww/Chroma"
ACTIVE_WINDOWS="$(${EWW_CMD} active-windows | awk -F ':' '{ print $1 }')"

function _tb_monit_card()
{
    if echo "${ACTIVE_WINDOWS}" | grep -q '\btop_bar_cards\b'; then
        ${EWW_CMD} update tb_cpu_card_revealer=false
        sleep 0.35
        ${EWW_CMD} close top_bar_cards
    else
        ${EWW_CMD} open top_bar_cards &&
        ${EWW_CMD} update tb_cpu_card_revealer=true
        echo "${1} ${2}"
    fi
}

function _left_panel()
{
    if echo "${ACTIVE_WINDOWS}" | grep -q '\bleft_panel\b'; then
        ${EWW_CMD} update tb_left_panel_revealer=false
        sleep 0.35
        ${EWW_CMD} close left_panel
    else
        ${EWW_CMD} open left_panel &&
        ${EWW_CMD} update tb_left_panel_revealer=true
    fi
}

function _top_bar()
{
    if echo "${ACTIVE_WINDOWS}" | grep -q '\btop_bar\b'; then
        ${EWW_CMD} close top_bar
    else
        ${EWW_CMD} open top_bar
    fi
}

function _tb_music_win()
{
    if echo "${ACTIVE_WINDOWS}" | grep -q '\btb_music_win\b'; then
        ${EWW_CMD} update tb_music_card_revealer=false
        sleep 0.35
        ${EWW_CMD} close tb_music_win
    else
        ${EWW_CMD} open tb_music_win &&
        ${EWW_CMD} update tb_music_card_revealer=true
    fi
}

case "${1}" in
    "--top_bar") _top_bar ;;
    "--left_panel") _left_panel ;;
    "--top_bar_music_win") _tb_music_win ;;
    "--top_bar_monit_card") _tb_monit_card "${2}" ;;
esac

#! /bin/bash

# Requires: 
# - socat

# ws1="1"
# ws2="2"
# ws3="3"
# ws4="4"
# ws5="5"
# ws6="6"
# ws7="7"
# ws8="8"
# ws9="9"
#
# # Unoccupied
# un="0"
#
# oc="$(workspace_id=$(hyprctl activeworkspace -j | jq -r '.id') && echo "$workspace_id")"
#


handle() {
  case $1 in
      workspace">>"*) echo $1 | awk -F '>>' '{ print $2 }' ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done

# generate_eww() {
#     active="$(awk -F '>>' '{ print $2 }' $1)"
#     cat << EOF >
#           (box :class "tb-workspaces"
#             :space-evenly false
#             :halign "center"
#             (

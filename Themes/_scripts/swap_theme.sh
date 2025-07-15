#!/bin/bash

G='\033[92m'
R='\033[91m'
C='\033[96m'
N='\033[0m'

scripts_dir="$(pwd)"

source "${HOME}/.cache/wal/colors.sh"

# Kitty
cp "${HOME}/.config/Themes/${1}/kitty/${1}.conf" \
    "${HOME}/.config/kitty/current-theme.conf"

if [[ "${?}" -eq 0 ]]; then
    printf "%b" "[${G}*${N}] Kitty theme changed to ${C}${1}${N}\n"
else
    printf "%b" "[${R}!${N}] Kitty theme couldn't be changed to ${C}${1}${N}\n"
fi

# Zathura
[[ ! -d "${HOME}/.config/zathura" ]] && mkdir "${HOME}/.config/zathura"
cp "${HOME}/.cache/wal/colors-zathura" "${HOME}/.config/zathura/zathurarc"

# Swww
swww img --transition-step=255 \
    --transition-fps=60 \
    --transition-duration=1.5 \
    --transition-type=left \
    "${HOME}/.config/Themes/${1}/wallpaper/background."???

if [[ "${?}" -eq 0 ]]; then
    printf "%b" "[${G}*${N}] Wallpaper changed to ${C}${1}${N}\n"
else
    printf "%b" "[${R}!${N}] Wallpaper couldn't be changed to ${C}${1}${N}\n"
fi

# pywal16
wal -n -s -t -e --theme "${HOME}/.config/Themes/${1}/wal/${1}.json" \
    1> "/dev/null" 2>&1

if [[ "${?}" -eq 0 ]]; then
    printf "%b" "[${G}*${N}] Wal scheme changed to ${C}${1}${N}\n"
else
    printf "%b" "[${R}!${N}] Wal scheme couldn't be changed to ${C}${1}${N}\n"
fi

# Rofi
cp "${HOME}/.config/Themes/${1}/rofi/background.png" "${HOME}/.config/rofi/"

if [[ "${?}" -eq 0 ]]; then
    printf "%b" "[${G}*${N}] Rofi theme changed to ${C}${1}${N}\n"
else
    printf "%b" "[${R}!${N}] Rofi theme couldn't be changed to ${C}${1}${N}\n"
fi

# Mako
source "${HOME}/.cache/wal/colors.sh"

# Associative array, color name -> color code.
declare -A colors
colors=(
    ["background-color"]="${background}"
    ["text-color"]="${foreground}"
    ["border-color"]="${color3}"
)

for color_name in "${!colors[@]}"; do
  # replace first occurance of each color in config file
  sed -i "0,/^$color_name.*/{s//$color_name=${colors[$color_name]}/}" \
      "${HOME}/.config/mako/config" 
  if [[ "${?}" -eq 0 ]]; then
    printf "%b" "[${G}*${N}] Mako color updated to ${color_name}\n"
  else
    printf "%b" "[${R}!${N}] Mako color ${color_name} could not be updated\n"
  fi
done

systemctl --user reload mako

# Eww
cp "${HOME}/.cache/wal/colors.scss" "${HOME}/.config/eww/Chroma/_global/"

if [[ "${?}" -eq 0 ]]; then
    printf "%b" "[${G}*${N}] Copied ${C}colors.scss${N} to "
    printf "%b" "${C}'${HOME}/.config/eww/Chroma'${N}\n"
else
    printf "%b" "[${R}!${N}] Could not copy ${C}colors.scss${N} to "
    printf "%b" "${C}'${HOME}/.config/eww/Chroma'${N}\n"
fi

"${scripts_dir}/svg_fill.py" "${HOME}/.config/eww/Chroma/assets/icons/" "${foreground}"
"${scripts_dir}/svg_fill.py" "${HOME}/.config/eww/Chroma/assets/color4/" "${color4}"

eww -c "${HOME}/.config/eww/Chroma" reload 1> "/dev/null" 2>&1
if [[ "${?}" -eq 0 ]]; then
    printf "%b" "[${G}*${N}] Reloaded ${C}eww${N} configuration\n"
else
    printf "%b" "[${R}!${N}] Could not reload ${C}eww${N} configuration\n"
fi

# Hyprlock
cp "${HOME}/.config/Themes/${1}/wallpaper/background.png" \
    "${HOME}/.config/hypr/hyprlock/assets/"
# magick "${HOME}/.config/hypr/hyprlock/assets/background.png" \
#     "${HOME}/.config/hypr/hyprlock/assets/background.jpg"
# rm "${HOME}/.config/hypr/hyprlock/assets/background.png"

# Fastfetch
cp "${HOME}/.config/Themes/${1}/fastfetch/background.png" \
    "${HOME}/.config/fastfetch/background.png"

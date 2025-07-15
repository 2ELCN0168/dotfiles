#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

if ! command -v convert >/dev/null 2>&1; then
        printf 'Error: "convert" command from ImageMagick is required.\n' >&2
        exit 1
fi

root_dir="${1:-.}"

find "${root_dir}" -type f \( -iname '*.jpg' -o -iname '*.jpeg' \) | while IFS= read -r img; do
        dir=$(dirname "${img}")
        filename=$(basename "${img}")
        name="${filename%.*}"
        output="${dir}/${name}.png"

        if [ -f "${output}" ]; then
                printf 'Skipping %s (already exists)\n' "${output}"
                continue
        fi

        printf 'Converting %s -> %s\n' "${img}" "${output}"
        if magick "${img}" "${output}"; then
                rm -f -- "${img}"
                printf 'Deleted original: %s\n' "${img}"
        else
                printf 'Error converting %s\n' "${img}" >&2
        fi
done

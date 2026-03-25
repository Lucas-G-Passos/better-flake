#!/usr/bin/env bash
set -o pipefail
appid="$1"
cache="$HOME/.cache/desktop-index"

find_desktop() {
    local filename="$1"
    IFS=: read -ra data_dirs <<< "${XDG_DATA_DIRS:-/usr/share}"
    local dirs=("$HOME/.local/share/applications")
    for dir in "${data_dirs[@]}"; do
        dirs+=("$dir/applications")
    done
    for dir in "${dirs[@]}"; do
        [[ -f "$dir/$filename" ]] && echo "$dir/$filename" && return 0
    done
    return 1
}

resolve() {
    local filename
    filename=$(grep -m1 "^$1|$appid|" "$cache" | cut -d'|' -f3) || return 1
    local path
    path=$(find_desktop "$filename") || return 1
    local icon
    icon=$(grep -m1 "^icon|.*|$filename" "$cache" | cut -d'|' -f2)
    local appname
    appname=$(grep -m1 "^Name=" "$path" | cut -d'=' -f2-)
    echo "appname=$appname"
    echo "desktop=$path"
    echo "icon=$icon"
}

resolve name && exit
resolve wmclass && exit
resolve exec
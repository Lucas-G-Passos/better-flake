#!/usr/bin/env bash
cache="$HOME/.cache/desktop-index"

IFS=: read -ra data_dirs <<< "${XDG_DATA_DIRS:-/usr/share}"

desktop_files=()
for dir in "${data_dirs[@]}"; do
    [[ -d "$dir/applications" ]] && \
        desktop_files+=("$dir/applications"/*.desktop)
done

[[ -d "$HOME/.local/share/applications" ]] && \
    desktop_files+=("$HOME/.local/share/applications"/*.desktop)

grep -H "^\(StartupWMClass\|Exec\|Icon\)=" \
    "${desktop_files[@]}" 2>/dev/null |
awk -F '[:=]' '
{
    file=$1; key=$2; value=$3
    sub(".*/","",file)
    sub(/\.desktop$/, "", file)
    print "name|" file "|" file ".desktop"
    if(key=="StartupWMClass")
        print "wmclass|" value "|" file ".desktop"
    if(key=="Exec"){
        split(value,a," ")
        print "exec|" a[1] "|" file ".desktop"
    }
    if(key=="Icon")
        print "icon|" value "|" file ".desktop"
}
' | sort -u > "$cache"
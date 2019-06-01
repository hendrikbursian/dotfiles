#! /usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

echo "Link dotfiles to home directory"
filelist="$DIR/filelist"
while IFS=" " read -r homefile target; do
    # Prevent creating duplicated links for directories
    if [[ -L "$HOME/$homefile" && "$(readlink "$HOME/$homefile")" == "$DIR/$target" ]]; then
        printf "'%s' -> '%s'\n" "$HOME/$homefile" "$DIR/$target"
        continue
    fi

    ln -fvs "$DIR/$target" "$HOME/$homefile"
done <"$filelist"

echo ""
echo "Link launch files from snap"
desktop_files="/var/lib/snapd/desktop/applications/*.desktop"
desktop_files_target=/usr/share/applications

[[ ! -d "$desktop_files_target" ]] && mkdir "$desktop_files_target"

for f in $desktop_files; do
    file_name=$(basename "$f")
    sudo ln -fvs "$f" "$desktop_files_target/$file_name"
done

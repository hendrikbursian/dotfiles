#! /usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

filelist="$DIR/filelist"
while IFS=" " read -r homefile target; do
    # Prevent creating duplicated links for directories
    if [[ -L "$HOME/$homefile" && "$(readlink "$HOME/$homefile")" == "$DIR/$target" ]]; then
        printf "'%s' -> '%s'\n" "$HOME/$homefile" "$DIR/$target"
        continue
    fi

    ln -fvs "$DIR/$target" "$HOME/$homefile"
done <"$filelist"

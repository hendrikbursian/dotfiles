#! /usr/bin/env bash
DIR=$(dirname $(readlink -f "$0"))

filelist="$DIR/filelist"
while IFS=" " read -r homefile target
do
    ln -fvs "$DIR/$target" "$HOME/$homefile"
done < "$filelist"
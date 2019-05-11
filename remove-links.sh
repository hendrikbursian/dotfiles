#! /usr/bin/env bash
DIR=$(dirname $(readlink -f "$0"))

filelist="$DIR/filelist"
while IFS=" " read -r homefile target
do
    [[ ! -z "$homefile" ]] && [[ ! -z "$target" ]] && rm -vr "$HOME/$homefile"
done < "$filelist"
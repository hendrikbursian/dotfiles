#! /usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")

filelist="$DIR/filelist"
while IFS=" " read -r homefile target
do
    [[ -n "$homefile" ]] && [[ -n "$target" ]] && rm -vr "${HOME:?}/$homefile"
done < "$filelist"
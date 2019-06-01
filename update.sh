#! /usr/bin/env bash
DIR=$(dirname "$(readlink -f "$0")")
cd "$DIR" || exit 1

./remove-links.sh

git pull --recurse-submodules

./add-links.sh

cd "$OLDDIR" || exit 1
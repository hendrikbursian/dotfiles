#! /usr/bin/env bash
DIR=$(dirname $(readlink -f "$0"))
cd "$DIR"

./remove-links.sh

git pull --recurse-submodules

./add-links.sh

cd "$OLDDIR"
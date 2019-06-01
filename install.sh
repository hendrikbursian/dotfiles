#! /usr/bin/env bash

DIR=$(dirname "$(readlink -f "$0")")

./installations/system.sh
./installations/asdf.sh
./installations/docker.sh
./installations/developer-tools.sh
./installations/autokey.sh

# brave (browser)
sudo snap install brave --edge

# spotify
sudo snap install spotify

# link dotfiles
sudo "$DIR/add-links.sh"
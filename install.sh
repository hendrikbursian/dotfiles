#! /usr/bin/env bash

DIR=$(dirname $(readlink -f "$0"))

sudo apt update -y && sudo apt upgrade -y
sudo apt-get install -y \
  vim \
  zsh \
  git \
  curl \
  jq \
  htop \
  dconf \
  snapd

./installations/asdf.sh
./installations/docker.sh
./installations/autokey.sh

# oh-my-zsh
curl -sSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh -s

# shellcheck
sudo snap install shellcheck --channel=edge

# shell format
sudo snap install shfmt

./installations/code.sh

# brave (browser)
sudo snap install brave --edge

# hugo
sudo snap install hugo --channel=extended

# krita
sudo snap install krita

# pall (color picker)
sudo snap install pall

# spotify
sudo snap install spotify

# link dotfiles
$DIR/add-links.sh

# install vim plugins
vim +'PlugInstall --sync' +qa

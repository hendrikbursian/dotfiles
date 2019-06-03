#!/usr/bin/env bash

sudo apt update -y && sudo apt upgrade -y
sudo apt-get install -y \
  vim \
  zsh \
  git \
  curl \
  jq \
  htop \
  snapd

sudo chsh -s /usr/bin/zsh

# oh-my-zsh
curl -sSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh -s

# install vim plugins
vim +'PlugInstall --sync' +qa

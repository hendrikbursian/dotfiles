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
  # needed for apt repositories that use https
  apt-transport-https \
  ca-certificates \
  gnupg-agent \
  software-properties-common

# oh-my-zsh
curl -sSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh -s

# install vim plugins
vim +'PlugInstall --sync' +qa

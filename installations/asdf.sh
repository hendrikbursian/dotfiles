#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get install -y \
  automake \
  autoconf \
  libreadline-dev \
  libncurses-dev \
  libssl-dev \
  libyaml-dev \
  libxslt-dev \
  libffi-dev \
  libtool \
  unixodbc-dev \
  unzip \
  curl
  
# git submodule update --init --recursive
# git checkout "$(git describe --abbrev=0 --tags)"

# asdf plugin-add python
# asdf plugin-add nodejs
# asdf plugin-add golang
# asdf plugin-add yarn

# Add gpg keyring
# ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

# Run this in $HOME
# asdf install

# With python3
# pip install bpython
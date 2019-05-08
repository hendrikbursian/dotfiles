#! /usr/bin/env bash
sudo add-apt-repository ppa:sporkwitch/autokey

sudo apt update && sudo apt upgrade

sudo apt-get install vim zsh git curl jq python-xlib autokey-gtk snapd

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -sL git.io/antibody | sh -s

sudo snap install shellcheck --channel=edge

sudo snap install code --classic

sudo snap install hugo --channel=extended

sudo snap install krita

sudo snap install spotify
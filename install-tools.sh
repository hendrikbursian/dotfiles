#! /usr/bin/env bash
sudo add-apt-repository -y ppa:sporkwitch/autokey

sudo apt update -y && sudo apt upgrade -y

sudo apt-get install -y vim zsh git curl jq python-xlib autokey-gtk snapd

curl -sSL git.io/antibody | sh -s

curl -sSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh -s

sudo snap install shellcheck --channel=edge

sudo snap install go

sudo snap install shfmt

sudo snap install code --classic
code --install-extension anjali.clipboard-history
code --install-extension dotjoshjohnson.xml
code --install-extension eamodio.gitlens
code --install-extension eg2.tslint
code --install-extension esbenp.prettier-vscode
code --install-extension foxundermoon.shell-format
code --install-extension mechatroner.rainbow-csv
code --install-extension peterjausovec.vscode-docker
code --install-extension pflannery.vscode-versionlens
code --install-extension ryu1kn.partial-diff
code --install-extension timonwong.shellcheck

sudo snap install hugo --channel=extended

sudo snap install krita

sudo snap install spotify

./link

echo "Done. Please start a new shell"
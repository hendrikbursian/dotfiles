#! /usr/bin/env bash

DIR=$(dirname $(readlink -f "$0"))

sudo add-apt-repository -y ppa:sporkwitch/autokey

sudo apt update -y && sudo apt upgrade -y 
sudo apt-get install -y vim zsh git curl jq python-xlib autokey-gtk dconf snapd

# nvm
curl -sSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | sh -s
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# yarn
curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update -y && sudo apt-get install -y --no-install-recommends yarn

# antibody
curl -sSL git.io/antibody | sh -s

# oh-my-zsh
curl -sSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh -s

# docker
curl -sSL https://get.docker.com | sh -s
sudo usermod -aG docker "$USER"

# docker compose
latesttagurl=$(curl -Lw "%{url_effective}\n" -o /dev/null -s http://github.com/docker/compose/releases/latest)
sudo curl -L "${latesttagurl/tag/download}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#kubernetes
sudo snap install microk8s --classic

# shellcheck
sudo snap install shellcheck --channel=edge

# golang
sudo snap install go

# shell format
sudo snap install shfmt

# vscode
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

# terminal customization
if [ "$XDG_CURRENT_DESKTOP" == "ubuntu:GNOME" ]; then
    echo "Found ubuntu gnome terminal. Load solarized theme and terminal profile"
    profileid=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    profilekey="/org/gnome/terminal/legacy/profiles:/:$profileid/"

    # Import profile settings
    dconf load "$profilekey" < ./terminal-profile.dconf

    # Install color scheme
    $DIR/solarized/install.sh --scheme dark --profile "$profileid" --install-dircolors
    rm "$HOME/.dir_colors.old"

    gnome-session-quit
fi
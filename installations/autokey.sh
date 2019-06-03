#! /usr/bin/env bash

sudo add-apt-repository -y ppa:sporkwitch/autokey
sudo apt update -y && apt-get install -y \
    python-xlib \
    autokey-gtk

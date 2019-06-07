#!/usr/bin/env bash

# docker
curl -sSL https://get.docker.com | sh -s
sudo usermod -aG docker "$USER"

# docker compose
latesttagurl=$(curl -Lw "%{url_effective}\n" -o /dev/null -s http://github.com/docker/compose/releases/latest)
sudo curl -L "${latesttagurl/tag/download}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#kubernetes
sudo snap install microk8s --classic
sudo snap alias microk8s.kubectl kubectl
sudo snap alias microk8s.istioctl istioctl

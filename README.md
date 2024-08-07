# Dotfiles

## Install (on NixOS)
```bash
git clone https://github.com/hendrikbursian/dotfiles.git ~Workspace/dotfiles
sudo nixos-rebuild -I nixos-config=$HOME/Workspace/dotfiles/configuration.nix switch
```

## Switching to a changed configuration 
sudo nixos-rebuild -I nixos-config=$DOTFILES/configuration.nix switch

## Build & start a vm
sudo nixos-rebuild -I nixos-config=$DOTFILES/configuration.nix build-vm && ./result/bin/run-*
-vm

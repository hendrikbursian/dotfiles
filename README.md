# Dotfiles

## Install (on NixOS)
```bash
git clone https://github.com/hendrikbursian/dotfiles.git ~Workspace/dotfiles
sudo nixos-rebuild --flake $HOME/Workspace/dotfiles switch
```

## Switching to a changed configuration 
```bash
sudo nixos-rebuild --flake $DOTFILES switch
```

## Build & start a vm
```bash
sudo nixos-rebuild --flake $DOTFILES switch
sudo nixos-rebuild --flake $DOTFILES build-vm && ./result/bin/run-*
-vm
```

## Build iso from configuration
```bash
nix run github:nix-community/nixos-generators -- --flake . --format iso
```
## Test in vm
```bash
qemu-system-x86_64 -enable-kvm -m 1024 -cdrom result/iso/nixos-*.iso
```

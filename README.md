# Setup

```bash
# Install git and curl
sudo apt install git curl

# Install nix
# Version 2.17.1 must be used as long as https://github.com/NixOS/nix/pull/9723 is not merged (Bug in `config.lib.file.mkOutOfStoreSymlink`)
sh <(curl -L https://releases.nixos.org/nix/nix-2.17.1/install) --daemon

# Clone repository
git clone https://github.com/hendrikbursian/dotfiles.git ~/.dotfiles

# Let home-manager install everything else
nix --extra-experimental-features nix-command --extra-experimental-features flakes run home-manager/master -- init --switch ~/.dotfiles/

# Set git ssh url
git -C ~/.dotfiles remote set-url origin git@github.com:hendrikbursian/dotfiles.git
```
# Run install script
```bash
~/.dotfiles/ansible/scripts/run_ansible.sh
```

## Run Sway on iGPU
```bash
# Adjust if nessecary
echo WLR_DRM_DEVICES=/dev/dri/by-path/pci-0000:00:02.0-card:/dev/dri/by-path/pci-0000:00:02.0-render > /etc/environment.d/80-regolith-sway.conf
```

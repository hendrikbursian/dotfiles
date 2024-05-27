# Setup

## Initial Installation

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

# Setup the rest
~/.dotfiles/ansible/scripts/run_ansible.sh
```

## Further installations
After the initial installation all further installations can be run with the following command:
```bash
home-manager switch --flake ~/.dotfiles
```

## Update home-manager dependencies
For updating dependencies that are managed with home-manger run the following command:
```bash
nix flake update ~/.dotfiles/
```

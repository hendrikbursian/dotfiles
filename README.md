# Setup

```bash
# Install git and ansible
sudo apt install git ansible

# Clone repository
git clone https://github.com/hendrikbursian/dotfiles.git ~/.dotfiles

# Run install script
~/.dotfiles/ansible/scripts/run_ansible.sh

# Install dotfiles
~/.dotfiles/ubuntu
```

## Run Sway on iGPU
```bash
# Adjust if nessecary
echo WLR_DRM_DEVICES=/dev/dri/by-path/pci-0000:00:02.0-card:/dev/dri/by-path/pci-0000:00:02.0-render > /etc/environment.d/80-regolith-sway.conf
```

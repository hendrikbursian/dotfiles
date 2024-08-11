{ pkgs, modulesPath, lib, ... }:
{
  imports = [
    # "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    # "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"

    # ../../modules/power-management.nix
    # ../../modules/nvidia/sync.nix
    # ../../modules/nvidia/offload.nix
    # ../../modules/nvidia/disable.nix

    # ../../modules/plymouth.nix
    ../../modules/system-pkgs.nix
    ../../modules/gnome.nix

    ../../modules/home-manager.nix
    ../../modules/users/hendrik.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  # power-management.module = "auto-cpufreq";
  # networking.wireless.enable = false;

  programs.zsh.enable = true;
}


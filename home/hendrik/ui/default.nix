{ pkgs, lib, config, ... }:

{
  imports = [
    ./sway.nix
    ./kanshi.nix
    ./wpaperd.nix
    ./wlsunset.nix
  ];

  services.mako.enable = true;
}


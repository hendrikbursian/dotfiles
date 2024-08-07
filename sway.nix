{ pkgs, lib, config, ... }:

{
  xdg.configFile = {
    sway = {
      source = config.lib.file.mkOutOfStoreSymlink ./.config/sway;
      recursive = true;
    };
    i3status-rust = {
      source = config.lib.file.mkOutOfStoreSymlink ./.config/i3status-rust;
      recursive = true;
    };
  };

  services.mako.enable = true;

  home.packages = with pkgs; [
    sway
    i3status-rust
    dmenu-rs
  ];

  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = config.home.homeDirectory + "/Pictures/Backgrounds";
        duration = "5m";
        sorting = "ascending";
        mode = "zoom";
      };
    };
  };
}

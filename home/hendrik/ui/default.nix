{ pkgs, lib, config, ... }:

{
  imports = [
    ./sway.nix
    ./kanshi.nix
    ./wpaperd.nix
    ./wlsunset.nix
  ];

  services.mako.enable = true;

  wayland.windowManager.hyprland = {
    enable = false;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      "$mod" = "SUPER";

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };

}


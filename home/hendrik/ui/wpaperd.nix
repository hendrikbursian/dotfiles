{ config, pkgs, ... }:
{
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        duration = "5m";
        sorting = "random";
        mode = "center";
      };
      any = {
        path = "${config.home.homeDirectory}/Pictures/Backgrounds";
        apply-shadow = true;
      };
    };
  };

  # manual systemd entry for wpaperd nessecary: https://github.com/nix-community/home-manager/issues/4538#issuecomment-1802328349
  systemd.user.services.wpaperd = {
    Unit = {
      Description = "Peeriodically changes background";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wpaperd}/bin/wpaperd -c ${config.xdg.configHome}/wpaperd/wallpaper.toml";
    };
    Install = {
      WantedBy = [ "sway-session.target" ];
    };
  };
}

{ pkgs, lib, config, ... }:

{
  xdg.configFile = {
    i3status-rust = {
      source = config.lib.file.mkOutOfStoreSymlink ./.config/i3status-rust;
      recursive = true;
    };
  };

  services.mako.enable = true;

  home.packages = with pkgs; [
    i3status-rust
    dmenu-rs
  ];

  wayland.windowManager.sway =
    let
      colors = {
        good = "#8ec07c";
        info = "#458588";
        focused = "#d65d0e";
        warn = "#d79921";
        inactive = "#323232";
        urgent = "#cc241d";
        text = "#eeeeec";
        text-inactive = "#babdb6";
        bar = "#000000";
        statusline = "#e0e0e0";
      };
      ws1 = "1 Konsole";
      ws2 = "2 Arbeit";
      ws3 = "3 Browser";
      ws4 = "4 Notizen";
      ws5 = "5 Nachrichten";
      ws6 = "6 Finanzen";
      ws7 = "7 Musik";
      ws8 = "8 Tagebuch";
      ws9 = "number 9";
      ws10 = "number 10";
    in
    {
      enable = true;
      config =
        {
          fonts = {
            names = [ "BlexMono Nerd Font" ];
            size = 9.0;
          };
          colors = {
            focused = {
              border = colors.focused;
              background = colors.focused;
              text = colors.text;
              indicator = colors.inactive;
              childBorder = colors.inactive;
            };
            unfocused = {
              border = colors.inactive;
              background = colors.inactive;
              text = colors.text-inactive;
              indicator = colors.bar;
              childBorder = colors.bar;
            };
            focusedInactive = {
              border = colors.inactive;
              background = colors.inactive;
              text = colors.text-inactive;
              indicator = colors.bar;
              childBorder = colors.bar;
            };
            urgent = {
              border = colors.urgent;
              background = colors.urgent;
              text = colors.text;
              indicator = colors.bar;
              childBorder = colors.bar;
            };
          };

          window = {
            border = 1;
            titlebar = false;
            commands = [
              {
                command = "opacity 0.8";
                criteria = { class = ".*"; };
              }
              {
                command = "opacity 0.8";
                criteria = { "app_id" = ".*"; };
              }
            ];
          };

          floating = {
            border = 0;
            criteria = [
              { class = "^org.gnome.TextEditor$"; }
              { app_id = "^org.gnome.TextEditor$"; }
              { class = "Bitwarden"; }
            ];
          };

          gaps = {
            inner = 10;
            outer = 10;
            smartGaps = false;
          };

          bars = [{
            id = "top";
            position = "top";
            statusCommand = "i3status-rs";
            workspaceButtons = true;
            trayOutput = "*";
            fonts = {
              names = [ "BlexMono Nerd Font" ];
              size = 9.0;
            };
            colors = {
              focusedWorkspace = {
                border = colors.focused;
                background = colors.focused;
                text = colors.text;
              };
            };
            extraConfig = ''
              strip_workspace_numbers no
            '';
          }];

          input = {
            "type:keyboard" = {
              repeat_delay = "240";
              repeat_rate = "60";
              xkb_options = "caps:escape";
              xkb_layout = "us,de";
            };

            "type:touchpad" = {
              accel_profile = "flat";
              dwt = "enabled";
              natural_scroll = "enabled";
              pointer_accel = "0.5";
              tap = "disabled";
            };
          };
          modifier = "Mod4";
          terminal = "foot";
          menu = "${pkgs.dmenu-rs}/bin/dmenu_path | ${pkgs.dmenu-rs}/bin/dmenu --insensitive --nb '${colors.bar}' --font 'BlexMono Nerd Font 9' | ${pkgs.findutils}/bin/xargs swaymsg exec --";
          seat = {
            "*" = { hide_cursor = "8000"; };
          };
          defaultWorkspace = ws1;
          startup = [
            { command = "swaymsg workspace $ws4"; }
            { command = "gnome-text-editor"; }
          ];
          keybindings =
            let
              modifier = config.wayland.windowManager.sway.config.modifier;
            in
            lib.mkOptionDefault
              {
                # Focuses
                "${modifier}+1" = "workspace ${ws1}";
                "${modifier}+2" = "workspace ${ws2}";
                "${modifier}+3" = "workspace ${ws3}";
                "${modifier}+4" = "workspace ${ws4}";
                "${modifier}+5" = "workspace ${ws5}";
                "${modifier}+6" = "workspace ${ws6}";
                "${modifier}+7" = "workspace ${ws7}";
                "${modifier}+8" = "workspace ${ws8}";
                "${modifier}+9" = "workspace ${ws9}";
                "${modifier}+0" = "workspace ${ws10}";

                # Moving
                "${modifier}+Shift+1" = "move container to workspace ${ws1}";
                "${modifier}+Shift+2" = "move container to workspace ${ws2}";
                "${modifier}+Shift+3" = "move container to workspace ${ws3}";
                "${modifier}+Shift+4" = "move container to workspace ${ws4}";
                "${modifier}+Shift+5" = "move container to workspace ${ws5}";
                "${modifier}+Shift+6" = "move container to workspace ${ws6}";
                "${modifier}+Shift+7" = "move container to workspace ${ws7}";
                "${modifier}+Shift+8" = "move container to workspace ${ws8}";
                "${modifier}+Shift+9" = "move container to workspace ${ws9}";
                "${modifier}+Shift+0" = "move container to workspace ${ws10}";

                # Moving & Focusing
                "${modifier}+Alt+1" = "move container to workspace ${ws1}; workspace ${ws1}";
                "${modifier}+Alt+2" = "move container to workspace ${ws2}; workspace ${ws2}";
                "${modifier}+Alt+3" = "move container to workspace ${ws3}; workspace ${ws3}";
                "${modifier}+Alt+4" = "move container to workspace ${ws4}; workspace ${ws4}";
                "${modifier}+Alt+5" = "move container to workspace ${ws5}; workspace ${ws5}";
                "${modifier}+Alt+6" = "move container to workspace ${ws6}; workspace ${ws6}";
                "${modifier}+Alt+7" = "move container to workspace ${ws7}; workspace ${ws7}";
                "${modifier}+Alt+8" = "move container to workspace ${ws8}; workspace ${ws8}";
                "${modifier}+Alt+9" = "move container to workspace ${ws9}; workspace ${ws9}";
                "${modifier}+Alt+0" = "move container to workspace ${ws10}; workspace ${ws10}";

                # TODO: test

                # File explorer
                "${modifier}+Shift+n" = "exec xdg-open /home/hendrik";

                # Browser 
                "${modifier}+Shift+Return" = "exec epiphany --new-window";

                # Dotfiles
                "${modifier}+Shift+d" = "exec foot tmux-sessionizer $DOTFILES";

                # Launcher
                "${modifier}+space" = "exec ${config.wayland.windowManager.sway.config.menu}";

                # Settings
                "${modifier}+c" = "XDG_CURRENT_DESKTOP=gnome gnome-control-center";

                # XKB Switcher
                "${modifier}+Alt+Backspace" = "input \"type:keyboard\" xkb_switch_layout next";

                # Sway commands
                "${modifier}+t" = "layout toggle all";
                "${modifier}+Shift+t" = "focus mode_toggle";
                "${modifier}+Shift+f" = "floating toggle";


                # Media keys
                "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+;";
                "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-;";
                "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle;";

                "XF86MonBrightnessDown" = "exec light -U 5";
                "XF86MonBrightnessUp" = "exec light -A 5";
              };
          modes = {
            resize = {
              Down = "resize grow height 32 px";
              Left = "resize shrink width 32 px";
              Return = "mode default";
              Right = "resize grow width 32 px";
              Up = "resize shrink height 32 px";
              h = "resize shrink width 32 px";
              j = "resize grow height 32 px";
              k = "resize shrink height 32 px";
              l = "resize grow width 32 px";
              Escape = "mode default";
            };
          };
        };
    };

  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        duration = "5m";
        sorting = "ascending";
        mode = "center";
      };
      eDP-1 = {
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


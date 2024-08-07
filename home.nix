{ pkgs, config, lib, ... }:

{
  imports = [
    ./tmux.nix
    ./zsh.nix
    ./sway.nix
    ./nvim.nix
  ];

  home.sessionVariables = {
    PATH = "$HOME/.local/bin:$PATH";
    DOTFILES = ./.;
  };

  xdg.enable = true;

  services.wlsunset = {
    enable = true;
    gamma = 0.8;
    # latitude = 52.52437;
    # longitude = 13.41053;
    sunrise = "06:30";
    sunset = "18:00";
    temperature = {
      day = 5000;
      night = 3000;
    };
  };


  home.packages = with pkgs; [
    (pkgs.nerdfonts.override {
      fonts = [ "IBMPlexMono" ];
    })

    # Fonts
    font-awesome

    # User
    gnumake
    mitmproxy
    nix-index
    socat
    tldr
    wl-clipboard
    wp-cli
    comma

    # Linters
    hadolint
    shellcheck

    # Apps
    bitwarden
    onlyoffice-bin_latest
    vlc
    brave
  ];

  home.file = {
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink ./.gitconfig;
    ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ./.rgignore;
    ".local/bin" = {
      source = config.lib.file.mkOutOfStoreSymlink ./.local/bin;
      recursive = true;
    };
  };

  programs.foot.enable = true;
  xdg.configFile.foot = {
    source = config.lib.file.mkOutOfStoreSymlink ./.config/foot;
    recursive = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    stdlib = ''
      #!/usr/bin/env bash

      # Two things to know:
      # * `direnv_layour_dir` is called once for every {.direnvrc,.envrc} sourced
      # * The indicator for a different direnv file being sourced is a different $PWD value
      # This means we can hash $PWD to get a fully unique cache path for any given environment

      declare -A direnv_layout_dirs
      direnv_layout_dir() {
          local hash path
          echo "''${direnv_layout_dirs[$PWD]:=$(
              hash="$(sha1sum - <<< "$PWD" | head -c40)"
              path="''${PWD//[^a-zA-Z0-9]/-}"
                        
              echo "${config.xdg.cacheHome}/direnv/layouts/''${hash}''${path}"
          )}"
      }
    '';

    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };


  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.05";
}

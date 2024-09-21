{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
    font-awesome

    # Languages
    go
    gopls
    gotools
    delve
    air
    templ

    nodejs_22
    corepack_22
    nodePackages_latest.pnpm
    typescript
    unstable.vscode-js-debug

    cargo
    rustc

    gcc
    python3
    zig

    # Linters
    hadolint
    shellcheck

    # User
    comma
    devenv
    eza
    gnumake
    mitmproxy
    nix-index
    pdftk
    socat
    tldr
    wget
    wl-clipboard
    sloc
    lynx
    w3m
    yt-dlp
    ffmpeg
    sqlitebrowser
    sqlite
    dbmate
    sqlc
    protonmail-bridge
    visidata

    # Apps
    bitwarden
    onlyoffice-bin_latest
    vlc
    brave
    firefox
    telegram-desktop
    dbeaver-bin
    zathura
    teams-for-linux
  ];

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

}

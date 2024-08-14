{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
    font-awesome

    # User
    gnumake
    mitmproxy
    nix-index
    socat
    tldr
    wl-clipboard
    comma
    devenv
    pdftk
    eza

    # Linters
    hadolint
    shellcheck

    # Apps
    bitwarden
    onlyoffice-bin_latest
    vlc
    brave
    firefox
    telegram-desktop
    dbeaver-bin
    zathura
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

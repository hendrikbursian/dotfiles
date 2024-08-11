{ pkgs, config, lib, ... }:

{
  options = {
    dotfiles = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/Workspace/dotfiles";
      description = "Dotfiles location";
    };
    dotfilesHome = lib.mkOption {
      type = lib.types.str;
      default = config.dotfiles + config.home.homeDirectory;
      description = "Home directory (i.e. /home/hendrik) in dotfiles";
    };
  };

  imports = [
    ./ui.nix
    ./zsh
    ./nvim.nix
    ./tmux.nix
    ./foot.nix
  ];

  config = {
    home = {
      username = "hendrik";
      homeDirectory = "/home/hendrik";

      sessionVariables = {
        PATH = "${config.home.homeDirectory}/.local/bin:$PATH";
        DOTFILES = config.dotfiles;
      };

      packages = with pkgs; [
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

        # Linters
        hadolint
        shellcheck

        # Apps
        bitwarden
        onlyoffice-bin_latest
        vlc
        brave
        telegram-desktop
        dbeaver-bin
      ];

      file = {
        ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesHome}/.gitconfig";
        ".rgignore".source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesHome}/.rgignore";
        ".local/bin" = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesHome}/.local/bin";
          recursive = true;
        };
      };
    };

    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;

        publicShare = null;
        templates = null;
        extraConfig = {
          XDG_WORKSPACE_DIR = "${config.home.homeDirectory}/Workspace";
          XDG_MOVIES_DIR = "${config.home.homeDirectory}/Movies";
        };
      };
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

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}

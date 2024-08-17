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
    ./ui
    ./foot.nix
    ./zsh
    ./nvim.nix
    ./tmux.nix
    ./programs.nix
  ];

  config = {
    home = {
      username = "hendrik";
      homeDirectory = "/home/hendrik";

      sessionVariables = {
        PATH = "${config.home.sessionVariables.GOPATH}/bin:${config.home.homeDirectory}/.local/bin:$PATH";
        GOPATH = "${config.home.homeDirectory}/go";
        DOTFILES = config.dotfiles;
      };

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

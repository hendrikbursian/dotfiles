{ inputs, pkgs, config, lib, ... }:


let
  defaultTheme = "nord-light";
in
{
  options = rec {
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
    inputs.base16.nixosModule
    {
      # https://tinted-theming.github.io/base16-gallery/
      scheme = (config.lib.base16.mkSchemeAttrs "${inputs.tt-schemes}/base16/${defaultTheme}.yaml").override {
        base00 = "ffffff";
      };
    }
    ./theming.nix

    ./ui
    ./foot.nix
    ./zsh
    ./nvim.nix
    ./tmux.nix
    ./programs.nix
    ./development.nix
  ];

  config = {
    xdg.configFile."theme".source = pkgs.writeTextFile {
      name = "theme"; # The name of the resulting file
      text = defaultTheme;
    };

    specialisation = {
      nord.configuration = {
        scheme = lib.mkForce "${inputs.tt-schemes}/base16/nord.yaml";

        xdg.configFile."theme".source = lib.mkForce (pkgs.writeTextFile {
          name = "theme"; # The name of the resulting file
          text = "nord";
        });
      };

      gruvbox.configuration = {
        scheme = lib.mkForce "${inputs.tt-schemes}/base16/gruvbox-dark-hard.yaml";

        xdg.configFile."theme".source = lib.mkForce (pkgs.writeTextFile {
          name = "theme"; # The name of the resulting file
          text = "gruvbox";
        });
      };
    };

    home = {
      username = "hendrik";
      homeDirectory = "/home/hendrik";

      sessionVariables = {
        GOPATH = "${config.home.homeDirectory}/.go";
        PNPM_HOME = "${config.xdg.dataHome}/pnpm";

        PATH = "${config.home.sessionVariables.GOPATH}/bin:${config.home.sessionVariables.PNPM_HOME}:${config.home.homeDirectory}/.local/bin:$PATH";
        DOTFILES = config.dotfiles;
        THEME_FILE = "${config.xdg.configHome}/theme";
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

{ callPackage
, config
, pkgs
, lib
, ...
}:

{
  imports = [
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hendrik";
  home.homeDirectory = "/home/hendrik";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  # ];

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # Programs
    pkgs.alarm-clock-applet
    pkgs.brave
    pkgs.masterpdfeditor
    pkgs.obsidian
    pkgs.onlyoffice-bin_latest
    pkgs.skypeforlinux
    pkgs.spotify
    pkgs.telegram-desktop

    pkgs.dbeaver-bin
    # pkgs.android-studio
    # pkgs.android-tools

    # Tools
    pkgs.bash
    pkgs.cacert
    pkgs.comma
    pkgs.curl
    pkgs.direnv
    pkgs.fd
    pkgs.fuse3
    pkgs.fzf
    pkgs.gawk
    pkgs.gcc-unwrapped
    pkgs.git
    pkgs.gnumake
    pkgs.gnupg
    pkgs.hadolint
    pkgs.htop
    pkgs.inotify-tools
    pkgs.iputils
    pkgs.jq
    pkgs.llvm
    pkgs.lynx
    pkgs.neovim
    pkgs.nettools
    pkgs.nix
    pkgs.nix-direnv
    pkgs.oh-my-zsh
    pkgs.redshift
    pkgs.ripgrep
    pkgs.rsync
    pkgs.shellcheck
    pkgs.socat
    pkgs.sshfs
    pkgs.stow
    pkgs.subversion
    pkgs.tldr
    pkgs.tmux
    pkgs.tree
    pkgs.unzip
    pkgs.vagrant
    pkgs.vim
    pkgs.wget
    pkgs.wp-cli
    pkgs.xsel
    pkgs.zsh

    # Languages
    # pkgs.zulu # java
    pkgs.go
    pkgs.nodejs_22

    # Formatters
    pkgs.nixpkgs-fmt
    pkgs.nodePackages_latest.eslint_d
    pkgs.nodePackages_latest.prettier
    pkgs.nodePackages_latest.sql-formatter
    pkgs.phpPackages.php-codesniffer
    pkgs.prettierd
    pkgs.shfmt
    pkgs.stylua

    # LSPs
    pkgs.gopls
    pkgs.lemminx # xml
    pkgs.lua-language-server
    pkgs.nodePackages_latest.intelephense
    pkgs.nodePackages_latest.volar
    pkgs.nodePackages_latest.vscode-css-languageserver-bin
    pkgs.nodePackages_latest.graphql-language-service-cli
    pkgs.nodePackages_latest.vscode-html-languageserver-bin
    pkgs.tailwindcss-language-server
    pkgs.templ

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".zshenv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.zshenv";
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.gitconfig";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.tmux.conf";
    ".asdfrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.asdfrc";
    ".rgignore".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.rgignore";
    ".tool-versions".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.tool-versions";

    ".local/bin" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.local/bin";
      recursive = true;
    };
  };

  xdg.configFile = {
    "nix" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/nix";
      recursive = true;
    };

    "zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/zsh";
      recursive = true;
    };

    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/nvim";
      recursive = true;
    };

    ".i3status-rust.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/.i3status-rust.conf";
    "regolith3" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/regolith3";
      recursive = true;
    };

    "asdf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/asdf";
      recursive = true;
    };

    "direnv" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/direnv";
      recursive = true;
    };

    # "redshift.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/redshift.conf";

    "systemd/user/default.target.wants/redshift.service".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/systemd/user/default.target.wants/redshift.service";
    "systemd/user/redshift.service".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/systemd/user/redshift.service";
  };

  home.activation.copyFiles = ''
    cp $DOTFILES/.config/redshift.conf $HOME/.config/
  '';

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hendrik/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

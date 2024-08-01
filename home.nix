{ nixGL, callPackage, config, pkgs, lib, username, homeDirectory, ... }:

let
  nixGLDefault = nixGL.packages."${pkgs.system}".nixGLDefault;
  nixGLNvidia = nixGL.packages."${pkgs.system}".nixGLNvidia;
  nixGLIntel = nixGL.packages."${pkgs.system}".nixGLIntel;
  nixVulkanNvidia = nixGL.packages."${pkgs.system}".nixVulkanNvidia;
  nixVulkanIntel = nixGL.packages."${pkgs.system}".nixVulkanIntel;
in
{
  # source: https://github.com/nix-community/home-manager/issues/3968#issuecomment-2135919008
  imports = [
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
      sha256 = "74f9fb98f22581eaca2e3c518a0a3d6198249fb1490ab4a08f33ec47827e85db";
    })
  ];
  nixGL.prefix = "${nixGLDefault}/bin/nixGL";

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
    # allowBroken = true;
    permittedInsecurePackages = [
    ];
  };


  fonts.fontconfig.enable = true;
  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "IBMPlexMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # Applications
    (config.lib.nixGL.wrap pkgs.alacritty)
    (config.lib.nixGL.wrap pkgs.brave)
    (config.lib.nixGL.wrap pkgs.firefox)
    (config.lib.nixGL.wrap pkgs.obsidian)
    (config.lib.nixGL.wrap pkgs.onlyoffice-bin_latest)
    (config.lib.nixGL.wrap pkgs.openshot-qt)
    (config.lib.nixGL.wrap pkgs.vlc)
    (config.lib.nixGL.wrap pkgs.skypeforlinux)
    (config.lib.nixGL.wrap pkgs.zathura)
    pkgs.alarm-clock-applet
    pkgs.masterpdfeditor
    pkgs.spotify

    nixGLDefault
    nixGLIntel
    nixGLNvidia
    nixVulkanIntel
    nixVulkanNvidia

    pkgs.dbeaver-bin
    # pkgs.android-studio
    pkgs.android-tools

    # Tools
    pkgs.asciidoctor-with-extensions
    pkgs.bash
    pkgs.cacert
    pkgs.comma
    pkgs.curl
    pkgs.direnv
    pkgs.fd
    pkgs.feh
    pkgs.fh
    pkgs.fuse3
    pkgs.fzf
    pkgs.gawk
    pkgs.gcc
    pkgs.git
    pkgs.gnumake
    pkgs.gnupg
    pkgs.hadolint
    pkgs.htop
    pkgs.i3status-rust
    pkgs.inotify-tools
    pkgs.iputils
    pkgs.jq
    pkgs.llvm
    pkgs.lynx
    pkgs.mitmproxy
    pkgs.neovim
    pkgs.nettools
    pkgs.nix
    pkgs.nix-direnv
    pkgs.oh-my-zsh
    pkgs.openssl.dev
    pkgs.pandoc
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

    # Libraries
    pkgs.xorg.libX11.dev
    pkgs.xorg.libXcursor.dev
    pkgs.xorg.libXext.dev
    pkgs.xorg.libXfixes.dev
    pkgs.xorg.libXi.dev
    pkgs.xorg.libXinerama.dev
    pkgs.xorg.libXrandr.dev
    pkgs.xorg.libXrender.dev
    pkgs.xorg.libXxf86vm

    # Languages
    # pkgs.zulu # java
    pkgs.go
    pkgs.nodejs_22
    pkgs.corepack_22
    pkgs.typescript
    pkgs.rustc
    pkgs.cargo

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
    pkgs.ccls
    pkgs.gopls
    pkgs.htmx-lsp
    pkgs.lemminx # xml
    pkgs.llvmPackages_18.clang-tools
    pkgs.lua-language-server
    pkgs.nodePackages_latest.graphql-language-service-cli
    pkgs.nodePackages_latest.intelephense
    pkgs.nodePackages_latest.typescript-language-server
    pkgs.rust-analyzer
    pkgs.tailwindcss-language-server
    pkgs.templ
    pkgs.vscode-langservers-extracted
    pkgs.vue-language-server
    pkgs.yaml-language-server

    # Debuggers
    pkgs.delve

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

    "regolith3" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/regolith3";
      recursive = true;
    };

    "i3status-rust" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/i3status-rust";
      recursive = true;
    };

    "direnv" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/direnv";
      recursive = true;
    };

    "systemd/user/default.target.wants/redshift.service".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/systemd/user/default.target.wants/redshift.service";
    "systemd/user/redshift.service".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/systemd/user/redshift.service";

    "systemd/user/next-bg.service".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/systemd/user/next-bg.service";
    "systemd/user/timers.target.wants/next-bg.timer".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/systemd/user/timers.target.wants/next-bg.timer";
    "systemd/user/next-bg.timer".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/systemd/user/next-bg.timer";
  };

  home.activation.copyFiles = ''
    cp $DOTFILES/.config/redshift.conf $HOME/.config/

    # cp $DOTFILES/.config/systemd/user/default.target.wants/next-bg.service $HOME/.config/systemd/user/default.target.wants/
    # cp $DOTFILES/.config/systemd/user/next-bg.service $HOME/.config/systemd/user/

    # cp $DOTFILES/.config/systemd/user/default.target.wants/next-bg.timer $HOME/.config/systemd/user/default.target.wants/
    # cp $DOTFILES/.config/systemd/user/next-bg.timer $HOME/.config/systemd/user/
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
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.obs-studio = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.obs-studio);
    plugins = [
      pkgs.obs-studio-plugins.droidcam-obs
    ];
  };
}

{ callPackage, config, pkgs, lib, username, homeDirectory, ... }:

{
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
    pkgs.alacritty
    pkgs.bitwarden
    pkgs.brave
    pkgs.firefox
    pkgs.obsidian
    pkgs.onlyoffice-bin_latest
    pkgs.openshot-qt
    pkgs.vlc
    pkgs.skypeforlinux
    pkgs.zathura
    pkgs.alarm-clock-applet
    pkgs.masterpdfeditor
    pkgs.spotify

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
    pkgs.nodePackages_latest.typescript-language-server
    pkgs.nodePackages_latest.vls
    pkgs.rust-analyzer
    pkgs.tailwindcss-language-server
    pkgs.templ
    pkgs.vscode-langservers-extracted
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
  };

  # redshift doesnt like symlinks
  home.activation.copyRedshiftConfig = ''
    cp "$HOME/.dotfiles/.config/redshift.conf" "$HOME/.config/"
  '';

  systemd.user.services.redshift = {
    Unit = {
      Description = "Redshift display colour temperature adjustment";
      Documentation = "http://jonls.dk/redshift/";
      After = "graphical-session.target";
    };
    Service = {
      ExecStart = "/bin/redshift";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services.next_bg = {
    Unit = {
      Description = "Changes background";
      After = "graphical-session.target";
    };
    Service = {
      ExecStart = "%h/.local/bin/next-bg";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.next_bg = {
    Unit = {
      Description = "Run next-bg periodically";
    };
    Timer = {
      OnCalendar = "*-*-* *:0/5:00";
      Persistent = "true";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

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
    VISUAL = "nvim";

    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$XDG_CONFIG_HOME/local/share";
    XDG_CACHE_HOME = "$XDG_CONFIG_HOME/cache";

    DOTFILES = "$HOME/.dotfiles";

    COMPOSER_HOME = "$XDG_CONFIG_HOME/composer";
    PNPM_HOME = "$XDG_DATA_HOME/pnpm";
    BUN_INSTALL = "$HOME/.bun";
    PYENV_ROOT = "$HOME/.pyenv";
    FLYCTL_INSTALL = "$HOME.fly";

    PATH = "/usr/local/bin:$HOME/bin:$HOME/.local/bin:$FLYCTL_INSTALL/bin:$HOME/.cargo/bin:$HOME/go/bin:$BUN_INSTALL/bin:$COMPOSER_HOME/vendor/bin:$HOME/.phpenv/bin:$PYENV_ROOT/bin:$PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  xdg.configFile."zsh" = {
    source = config.lib.file.mkOutOfStoreSymlink "$DOTFILES/.config/zsh";
    recursive = true;
  };

  # TODO: add in zsh config: fpath+=(/usr/share/zsh/site-functions)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    cdpath = [
      "~/Workspace/Personal"
      "~/Workspace/Freelancing"
      "~/.dotfiles"
    ];
    defaultKeymap = "viins";
    history.size = 20000;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [
        "^K"
        "^[[A"
      ];
      searchDownKey = [
        "^J"
        "^[[B"
      ];
    };

    envExtra = ''
      if [ -e /home/hendrik/.nix-profile/etc/profile.d/nix.sh ]; then . /home/hendrik/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';

    initExtraBeforeCompInit = ''
      export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-''${HOST/.*/}-''${ZSH_VERSION}"
    '';

    completionInit = ''
      _comp_options+=(globdots) # complete dotfiles
      autoload -U compinit && compinit

      source /usr/share/doc/fzf/examples/key-bindings.zsh
      source /usr/share/doc/fzf/examples/completion.zsh
    '';

    initExtra = ''
      export COLORTERM="truecolor"

      source "$ZDOTDIR"/dircolors # Generated by: $ dircolors $ZDOTDIR/.dircolors > $ZDOTDIR/dircolors
      source "$ZDOTDIR"/functions

      source /usr/share/fzf/completion.zsh
      source /usr/share/fzf/key-bindings.zsh

      # ZSH Config
      export ENABLE_CORRECTION="false"
      export DISABLE_MAGIC_FUNCTIONS="true"
      export COMPLETION_WAITING_DOTS="false"
      export DISABLE_UNTRACKED_FILES_DIRTY="true"

      # Export DISPLAY on WSL
      if grep -qi microsoft /proc/version; then
          export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"
          export LIBGL_ALWAYS_INDIRECT=1
      fi

      export PROMPT='$(_user_host)''${_current_dir} $(git_prompt_info)
      %{$fg[$CARETCOLOR]%}▶%{$resetcolor%} '

      # Fast directory switching
      setopt AUTO_PUSHD           # Push the current directory visited on the stack.
      setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
      setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

      alias d='dirs -v'
      for index ({1..9}) alias "$index"="cd +''${index}"; unset index

      # Keyinds
      bindkey -s ^f "tmux-sessionizer\n"
      bindkey -v
      bindkey -s ^a "tmux\n"
      bindkey -M vicmd ^e edit-command-line

      # Change cursor shape for different vi modes.
      function zle-keymap-select {
          if [[ ''${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
              echo -ne '\e[1 q'
      
          elif [[ ''${KEYMAP} == main ]] ||
              [[ ''${KEYMAP} == viins ]] ||
              [[ ''${KEYMAP} = "" ]] ||
              [[ $1 = 'beam' ]]; then
              echo -ne '\e[5 q'
          fi
      }
      zle -N zle-keymap-select

      # Remove mode switching delay.
      export KEYTIMEOUT=1

      # Use vim keybinds in menu selection
      zmodload zsh/complist
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      # Add text objects
      autoload -Uz select-bracketed select-quoted
      zle -N select-quoted
      zle -N select-bracketed
      for km in viopp visual; do
        bindkey -M $km -- '-' vi-up-line-or-history
        for c in {a,i}''${(s..)^:-\'\"\`\|,./:;=+@}; do
          bindkey -M $km $c select-quoted
        done
        for c in {a,i}''${(s..)^:-'()[]{}<>bB'}; do
          bindkey -M $km $c select-bracketed
        done
      done

      # Add "surround" functionality
      autoload -Uz surround
      zle -N delete-surround surround
      zle -N add-surround surround
      zle -N change-surround surround
      bindkey -M vicmd cs change-surround
      bindkey -M vicmd ds delete-surround
      bindkey -M vicmd ys add-surround
      bindkey -M visual S add-surround
    '';

    shellAliases = {
      e = "explorer.exe";
      vim = "nvim";
      v = "nvim";
      # nvim-lazy="NVIM_APPNAME=nvim-lazy nvim";
      # vl="nvim-lazy";
      vf = "fzf | xargs nvim";
      dc = "docker-compose";
      gcf = "git commit --fixup";
      gwt = "git worktree";
      gwtf = "git-fetch-worktree";
      gwtl = "git worktree list";
      gwtr = "git worktree remove";
      gwtm = "git worktree remove";
      gwta = "git-add-worktree";
      grbid = "git-rebase-interactive-branch-root";
      genssl = "openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout ssl.key -out ssl.cert -subj \"/CN=127.0.0.1/\"";
      gpriv = "git config user.email \"hendrikbursian@protonmail.com\" && git config user.name \"Hendrik Bursian\"";
      gu = "git undo";
      x = "chmod +x";
      f = "fzf --preview 'cat {}'";
      y = "yarn";
      gcl = "gitlab-ci-local";
      pd = "popd";
      pud = "pushd";
      t = "trans";
      kp = "kill-port";
      ".." = "cd ..";
      "..." = "cd ../..";

      # This is specific to WSL 2. If the WSL 2 VM goes rogue and decides not to free;
      # up memory, this command will free your memory after about 20-30 seconds.;
      #   Details: https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643;
      drop_cache = "sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\"";
    };

    oh-my-zsh = {
      enable = true;
      theme = "avit";
      plugins = [
        "git"
        "fzf"
        "vi-mode"
        "direnv"
      ];
    };
  };

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio;
    plugins = [
      pkgs.obs-studio-plugins.droidcam-obs
    ];
  };
}

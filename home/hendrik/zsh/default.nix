{ inputs, pkgs, config, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    cdpath = [
      "~/Workspace/Personal"
      "~/Workspace/Freelancing"
    ];
    defaultKeymap = "viins";
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      save = 20000;
      size = 20000;
    };
    historySubstringSearch = {
      enable = true;
      searchDownKey = [
        "^[[B"
        "^N"
      ];
      searchUpKey = [
        "^[[A"
        "^P"
      ];
    };

    sessionVariables = {
      COLORTERM = "truecolor";

      # LS_COLORS = ''
      #   # Directories
      #   di=${config.theme.colors.base16.base09};  # glacier (base09)

      #   # Symbolic links
      #   ln=${config.theme.colors.base16.base08};  # off_blue (base08)

      #   # Pipes
      #   pi=${config.theme.colors.base16.base02};  # gray (base02)

      #   # Executables
      #   ex=${config.theme.colors.base16.base0D};  # yellow (base0D)

      #   # Block devices
      #   bd=${config.theme.colors.base16.base0E};  # green (base0E);${config.theme.colors.base16.base0B};  # with background red (base0B)

      #   # Character devices
      #   cd=${config.theme.colors.base16.base0E};  # green (base0E);${config.theme.colors.base16.base0B};  # with background red (base0B)

      #   # Sockets
      #   so=${config.theme.colors.base16.base0F};  # purple (base0F)

      #   # Orphaned symbolic links
      #   or=${config.theme.colors.base16.base0B};  # red (base0B)

      #   # Missing files
      #   mi=${config.theme.colors.base16.base0B};  # red (base0B)

      #   # Files with setuid bit set
      #   su=${config.theme.colors.base16.base0B};  # red (base0B);${config.theme.colors.base16.base01};  # with background dark_gray (base01)

      #   # Files with setgid bit set
      #   sg=${config.theme.colors.base16.base0B};  # red (base0B);${config.theme.colors.base16.base01};  # with background dark_gray (base01)

      #   # Directories writable to others, with sticky bit
      #   tw=${config.theme.colors.base16.base0D};  # yellow (base0D);${config.theme.colors.base16.base01};  # with background dark_gray (base01)

      #   # Directories writable to others, without sticky bit
      #   ow=${config.theme.colors.base16.base0B};  # red (base0B);${config.theme.colors.base16.base01};  # with background dark_gray (base01)

      #   # Normal files
      #   fi=${config.theme.colors.base16.base03};  # light_gray (base03)

      #   # Archives and compressed files
      #   *.tar=${config.theme.colors.base16.base0D};  # yellow (base0D)
      #   *.zip=${config.theme.colors.base16.base0D};  # yellow (base0D)
      #   *.gz=${config.theme.colors.base16.base0D};  # yellow (base0D)
      #   *.bz2=${config.theme.colors.base16.base0D};  # yellow (base0D)
      #   *.xz=${config.theme.colors.base16.base0D};  # yellow (base0D)

      #   # Images
      #   *.jpg=${config.theme.colors.base16.base0E};  # green (base0E)
      #   *.png=${config.theme.colors.base16.base0E};  # green (base0E)
      #   *.gif=${config.theme.colors.base16.base0E};  # green (base0E)

      #   # Documents
      #   *.pdf=${config.theme.colors.base16.base0B};  # red (base0B)
      #   *.doc=${config.theme.colors.base16.base0B};  # red (base0B)
      #   *.txt=${config.theme.colors.base16.base06};  # white (base06)
      # '';

      ENABLE_CORRECTION = "false";
      DISABLE_UNTRACKED_FILES_DIRTY = "true";
      HIST_STAMPS = "yyyy-mm-dd";
    };

    loginExtra = ''
      [ "$(tty)" = "/dev/tty1" ] && exec sway --unsupported-gpu
    '';

    initExtra =
      lib.readFile (./functions.zsh) +
      ''
         # Show hidden files
         setopt globdots

         bindkey -s ^f "tmux-sessionizer\n"
         bindkey -s ^a "tmux\n"
         bindkey -M vicmd ^e edit-command-line
         bindkey -v

         # Autosuggestion
         bindkey '^l' forward-word
         bindkey '^x' autosuggest-accept
        
        
         # Fzf-tab
         # disable sort when completing `git checkout`
         zstyle ':completion:*:git-checkout:*' sort false
         # set descriptions format to enable group support
         # NOTE: don't use escape sequences here, fzf-tab will ignore them
         zstyle ':completion:*:descriptions' format '[%d]'
         # set list-colors to enable filename colorizing
         zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
         # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
         zstyle ':completion:*' menu no
         # preview directory's content with eza when completing cd
         zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
         # switch group using `<` and `>`
         zstyle ':fzf-tab:*' switch-group '<' '>'

         # Don't complete ./ 
         zstyle ':completion:*' ignore-parents 'parent pwd directory'

         # Remove mode switching delay.
         export KEYTIMEOUT=5;
        
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
        echo -ne '\e[5 q'
        
         NEWLINE=$'\n'
         export PROMPT='$(_user_host)''${_current_dir} $(git_prompt_info)''${NEWLINE}%{$fg[$CARETCOLOR]%}▶%{$resetcolor%} '
        
         # Overrides
         [ -s "$ZDOTDIR/.zshrc.local" ] && source "$ZDOTDIR/.zshrc.local"

      '';

    shellAliases = {
      vim = "nvim";
      v = "nvim";
      # nvim-lazy = "NVIM_APPNAME=nvim-lazy nvim";
      # vl = "nvim-lazy";
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
      gpriv = "git config user.email 'hendrikbursian@protonmail.com' && git config user.name 'Hendrik Bursian'";
      gu = "git undo";
      gensslcert = "openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout ssl.key -out ssl.cert -subj \"/CN=127.0.0.1/\"";
      gensshkey = "ssh-keygen -t ed25519 -C \"hendrikbursian@protonmail.com\"";
      x = "chmod +x";
      o = "xdg-open";
      kp = "kill-port";
      sc = "grim - \"$(slurp)\" | wl-copy";
      yt = "yt-dlp --format-sort vcodec:h265,width:480,+filesize,acodec:m4a --format 'bestaudio+bestvideo*/best' --output './%(playlist|)s/%(playlist_index&{:02d} - |)s%(uploader)s - (%(upload_date>%Y-%m-%d)s) %(title)s [%(id)s].%(ext)s'";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "master";
          sha256 = "B+Kz3B7d97CM/3ztpQyVkE6EfMipVF8Y4HJNfSRXHtU=";
        };
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "master";
          sha256 = "By6Bgc8Fu79eNTSfCusT57RP7P3XHeekjp4YhsKZS1Y=";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      theme = "avit";
      plugins = [
        "git"
        "vi-mode"
      ];
    };
  };
}


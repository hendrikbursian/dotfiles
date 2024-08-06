{ pkgs, config, lib, ... }:

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
      "/etc/nixos"
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

      ENABLE_CORRECTION = "false";
      DISABLE_UNTRACKED_FILES_DIRTY = "true";
      HIST_STAMPS = "yyyy-mm-dd";
    };

    loginExtra = ''
      [ "$(tty)" = "/dev/tty1" ] && exec sway
    '';

    initExtra =
      lib.readFile (./. + "/zsh/dircolors") +
      lib.readFile (./. + "/zsh/functions.zsh") +
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
      x = "chmod +x";
      kp = "kill-port";
    };

    plugins = [
      {
        name = "fzf-zsh-plugin";
        src = pkgs.fetchFromGitHub {
          owner = "unixorn";
          repo = "fzf-zsh-plugin";
          rev = "main";
          sha256 = "caSV6TBsLR3ifWOetSB13QwihyKYieI9HNJJKIV8yaY=";
        };
      }
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

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
      LS_COLORS = ''no=0;38;15:rs=0:di=1;34:ln=01;35:mh=00:pi=40;33:so=1;38;211:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=30;42:st=37;44:ex=1;30;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;33:*.au=01;33:*.flac=01;33:*.mid=01;33:*.midi=01;33:*.mka=01;33:*.mp3=01;33:*.mpc=01;33:*.ogg=01;33:*.ra=01;33:*.wav=01;33:*.axa=01;33:*.oga=01;33:*.spx=01;33:*.xspf=01;33:*.doc=01;91:*.ppt=01;91:*.xls=01;91:*.docx=01;91:*.pptx=01;91:*.xlsx=01;91:*.odt=01;91:*.ods=01;91:*.odp=01;91:*.pdf=01;91:*.tex=01;91:*.md=01;91:'';

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
      kp = "kill-port";
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


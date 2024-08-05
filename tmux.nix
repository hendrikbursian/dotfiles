{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    disableConfirmationPrompt = true;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    resizeAmount = 10;
    terminal = "screen-256color";
    escapeTime = 10;
    baseIndex = 1;
    aggressiveResize = true;

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];

    extraConfig = ''
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set -ga terminal-overrides ",*256col*:Tc"

      set -g status-bg black
      set -g status-fg white

      set-option -g focus-events on
      set -g display-time 4000
      
      # Status bar
      set -g status-position bottom
      set -g status-justify left
      set -g status-right '#(date "+%%a %%d/%%m %%H:%%M")'
      set -g status-right-length 50
      set -g status-left-length 20
      set -g status-left '#S - '

      setw -g window-status-format '#I:#W'
      set-option -g window-status-current-style bg=#aaaaaa,fg=#333333
      setw -g window-status-separator ' | '

      # Pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Easier and faster switching between next/prev window
      bind C-p previous-window
      bind C-n next-window

      # Set new panes to open in current directory
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Direct binds 
      bind-key -r C-j run-shell "~/.local/bin/tmux-sessionizer ~/.dotfiles"
    '';
  };
}

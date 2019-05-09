export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hendrik/.oh-my-zsh"
export ZSH_CUSTOM="/home/hendrik/.zsh_custom"

export GOPATH="/snap/bin/go"

ZSH_THEME="avit"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    docker
    docker-compose
)

source $ZSH/oh-my-zsh.sh

# Editor settings
export VISUAL=vim
export EDITOR="$VISUAL"

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# History settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096

# NVM environment
export NVM_DIR="/home/hendrik/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Dircolors for solarized theme
eval `dircolors ~/.dir_colors`

source <(antibody init)

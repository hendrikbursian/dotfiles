# Profiling
#zmodload zsh/zprof


export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh_custom"

export GOPATH="/snap/bin/go"

ZSH_THEME="avit"

plugins=(
    git
    docker
    docker-compose
)
source $ZSH/oh-my-zsh.sh

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

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
function load_nvm() {
    if alias nvm 2>/dev/null; then 
        unalias nvm
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
        nvm "$@"
    else 
        nvm "$@"
    fi
}
alias nvm='load_nvm'

autoload -U add-zsh-hook
load-nvmrc() {
    if [[ -f ".nvmrc" ]]; then
        nvm use
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Dircolors for solarized theme
eval `dircolors $HOME/.dir_colors/dircolors`

# Profiling
# zprof
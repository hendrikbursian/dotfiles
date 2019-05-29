# Profiling
#zmodload zsh/zprof

export PATH=$HOME/.local/bin:.$HOME/bin:/usr/local/bin:/snap/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh_custom"

ZSH_THEME="avit"

plugins=(
    git
    docker
    docker-compose
    terminal-toggl
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

# ASDF
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Profiling
# zprof

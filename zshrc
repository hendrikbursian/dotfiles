# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/hendrik/.oh-my-zsh"
export ZSH_CUSTOM="/home/hendrik/.zsh_custom"

ZSH_THEME="avit"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(
    git
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

eval `dircolors ~/.dir_colors/dircolors`

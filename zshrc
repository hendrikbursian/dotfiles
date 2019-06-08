# Profiling
# zmodload zsh/zprof

export PATH="$HOME/.local/bin:.$HOME/bin:/usr/local/bin:/snap/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh_custom"

ZSH_THEME="avit"

plugins=(
    git
    docker
    docker-compose
)

# Oh my zsh
source "$ZSH/oh-my-zsh.sh"

# asdf-vm
source "$HOME/.asdf/asdf.sh"
source "$HOME/.asdf/completions/asdf.bash"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Editor settings
export VISUAL=vim
export EDITOR="$VISUAL"

# Enable globbing to include hidden files (.*)
setopt dotglob

# History settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=4096
SAVEHIST=4096

[[ -f "$HOME/local/.zshrc" ]] && source "$HOME/.local/.zshrc"

# Profiling
# zprof

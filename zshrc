# Profiling
# zmodload zsh/zprof

export PATH="$HOME/.local/bin:.$HOME/bin:/usr/local/bin:/snap/bin:$HOME/dotnet:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.zsh_custom"
export DOTFILES="$(dirname "$(readlink $HOME/.zshrc)")"
export DOTNET_ROOT="$HOME/dotnet"

export DOTNET_CLI_TELEMETRY_OPTOUT=1

ZSH_THEME="avit"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    docker
    docker-compose
)

# oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

# asdf-vm
source "$HOME/.asdf/asdf.sh"
source "$HOME/.asdf/completions/asdf.bash"

# kubectl
[[ $(microk8s.kubectl completion zsh) != *"microk8s is not running"* ]] && source <(microk8s.kubectl completion zsh)

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

# Load local .zshrc
[[ -f "$HOME/.local/.zshrc" ]] && source "$HOME/.local/.zshrc"

# Profiling
# zprof

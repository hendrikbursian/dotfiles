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
    toggl
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

# open https://toggl.com/app/workspaces. Select the workspace you want to use,
# click on the three dots and open "Settings". Get the id from the URL in your
# browser. Eg. https://toggl.com/app/workspaces/12345678/settings?
export TOGGL_WORKSPACE_ID="1469640"

# open https://www.toggl.com/app/projects and select the project(s) you want to
# use in the report. Again copy the id from the url. In this case
# https://www.toggl.com/app/projects/12345678/edit/98765 the id would be 98765.
# This value can look like: "98765" or "98765,43210" for multiple project ids.
export TOGGL_PROJECT_IDS="19091233,30863060,24034734,150135856"

# open https://toggl.com/app/profile and get the API token from the bottom of
# the page
export TOGGL_API_TOKEN="eb175480b2ea71ccfb38710f74aed348"




# Profiling
# zprof
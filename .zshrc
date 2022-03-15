# Are we in the bottle?
if [[ ! -v INSIDE_GENIE ]]; then
  read -t 5 yn\?"Preparing to enter genie bottle in 5s. Enter [Yn]? "

  if [[ $yn != "n" ]]; then
    # Save path to file (includes vscode and other paths that are not automatically added when entering genie bottle
    echo $PATH > /tmp/.zshrc.path.tmp

    exec /usr/bin/genie -s
  fi
else
  echo "Entered bottle"

  [[ -f /tmp/zshrc.path.tmp ]] && export PATH=$(cat /tmp/.zshrc.path.tmp) && rm /tmp/.zshrc.path.tmp

  # Start lxpolkit when entering bottle
  if [[ ! -n $(ps -a | grep lxpolkit) ]]; then
    echo "Starting lxpolkit in background"
    lxpolkit &
  fi
fi

## Point to Windows XServer
export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2; exit;}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$HOME/.phpenv/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="avit"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  git
  docker
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='vim'

PROMPT='$(_user_host)${_current_dir} $(git_prompt_info)
%{$fg[$CARETCOLOR]%}▶%{$resetcolor%} '

eval $(dircolors $HOME/.dircolors)
source $HOME/.local/share/nvim/plugged/gruvbox/gruvbox_256palette.sh

alias e="explorer.exe"
alias c="code"
alias gcf="git commit --fixup"
alias ssl='openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout ssl.key -out ssl.cert -subj "/CN=127.0.0.1/"'
alias dot="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

function read_env() {
  set -o allexport
  [[ -f .env ]] && source .env
  set +o allexport
}

# Function to delegate to Windows to open each of its arguments
start() {
  for file in "$@"; do
    cmd.exe /C "$file"
  done
}
compdef _files start

# Wordpress CLI completions
source $HOME/.local/completions/wp-completion.bash

# PHP env
eval "$(phpenv init -)"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

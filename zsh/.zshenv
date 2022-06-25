#!/usr/bin/env zsh

export COLORTERM="truecolor"

export DOTFILES="$HOME/.dotfiles"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# ZSH Config
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="avit"
export ENABLE_CORRECTION="false"
export DISABLE_MAGIC_FUNCTIONS="true"
export COMPLETION_WAITING_DOTS="false"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$XDG_CACHE_HOME/zsh/history
export HIST_STAMPS="yyyy-mm-dd"

export PROMPT='$(_user_host)${_current_dir} $(git_prompt_info)
%{$fg[$CARETCOLOR]%}▶%{$resetcolor%} '
export _Z_DATA="$XDG_DATA_HOME/z/z"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Misc
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/.default-npm-packages"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/.default-python-packages"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# Path
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.phpenv/bin:$PATH"
export PATH="$HOME/neovim/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PNPM_HOME:$PATH"

# WSL XServer
#export DISPLAY="$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2; exit;}'):0.0"
export DISPLAY=$(/sbin/ip route | awk '/default/ { print $3 }'):0
export LIBGL_ALWAYS_INDIRECT=1

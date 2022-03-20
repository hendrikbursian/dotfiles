#!/usr/bin/env zsh

export DOTFILES="$HOME/.dotfiles"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# ZSH Config
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="avit"
export ENABLE_CORRECTION="false"
export DISABLE_MAGIC_FUNCTIONS="true"
export COMPLETION_WAITING_DOTS="false"
export DISABLE_UNTRACKED_FILES_DIRTY="true"
export HIST_STAMPS="yyyy-mm-dd"
export PROMPT='$(_user_host)${_current_dir} $(git_prompt_info)
%{$fg[$CARETCOLOR]%}▶%{$resetcolor%} '
export _Z_DATA="$XDG_DATA_HOME/z/z"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Misc
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"

# Path
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"
export PATH="$HOME/.phpenv/bin:$PATH"
export PATH="$HOME/neovim/bin:$PATH"
export PATH="$HOME/phpactor/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

# WSL XServer
export DISPLAY="$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2; exit;}'):0.0"
export LIBGL_ALWAYS_INDIRECT=1

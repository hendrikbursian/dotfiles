#!/usr/bin/env zsh

export DOTFILES="$HOME/.dotfiles"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR="nvim"
export VISUAL="nvim"

# ZSH Config
export PROMPT='$(_user_host)${_current_dir} $(git_prompt_info)
%{$fg[$CARETCOLOR]%}▶%{$resetcolor%} '


if [ -e /home/hendrik/.nix-profile/etc/profile.d/nix.sh ]; then . /home/hendrik/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

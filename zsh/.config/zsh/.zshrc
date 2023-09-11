# Export DISPLAY on WSL
if grep -qi microsoft /proc/version; then
    export DISPLAY=$(/sbin/ip route | awk '/default/ { print $3 }'):0
    export LIBGL_ALWAYS_INDIRECT=1
fi

# ZSH Config
plugins=(
  asdf
  git
  z
  fzf
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# FZF
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

source $ZDOTDIR/dircolors # Generated by: $ dircolors $ZDOTDIR/.dircolors > $ZDOTDIR/dircolors
source $ZDOTDIR/aliases
source $ZDOTDIR/functions

# Share history between shells
setopt SHARE_HISTORY

bindkey -s ^f "tmux-sessionizer\n"
bindkey -v
bindkey -s ^a "tmux\n"
bindkey -M vicmd ^e edit-command-line

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'

    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
precmd() {
    echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# Completion
_comp_options+=(globdots) # complete dotfiles

if command -v phpenv &> /dev/null
then
  # PHPenv
  eval "$(phpenv init -)"
fi


# WP CLI
[ -s "$HOME/.local/completions/wp-completions.bash" ] && source $HOME/.local/completions/wp-completion.bash

[ -s "$ZDOTDIR/.zshrc.local" ] && source "$ZDOTDIR/.zshrc.local"

function load_plugins() {
    echo "Load plugins"
    echo ""
    echo "$HOME/.zsh_plugins -> $ZSH_CUSTOM/plugins.zsh"
    echo ""
    echo "### $HOME/.zsh_plugins"
    cat $HOME/.zsh_plugins
    echo ""

    antibody bundle < $HOME/.zsh_plugins > $ZSH_CUSTOM/plugins.zsh

    echo "### $ZSH_CUSTOM/plugins.zsh"
    cat $ZSH_CUSTOM/plugins.zsh
    echo ""
    echo "Done"
}

function timer() {
    if [ $1 -gt 5]; then
        at now + $1 minutes <<<'notify-send 5 minutes left for '$2
    fi
    at now + $1 minutes <<<'notify-send timer expired for '$2
}
function __load_plugins() {
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

function __set_transparency() {
    local transparency=$1
    
    [[ ! -z "$transparency" ]] || transparency=95

    sh -c "xprop -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $(printf 0x%x $((0xffffffff * transparency / 100)))"
}
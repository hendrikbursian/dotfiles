#! /usr/bin/env bash

function __set_transparency() {
    local transparency=$1
    
    [[ -n "$transparency" ]] || transparency=90

    sh -c "xprop -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $(printf 0x%x $((0xffffffff * transparency / 100)))"
}

# Kills running process on given port
function __killport() {
    port="$1"

    process=$(lsof -n -i4TCP:"$port" | grep LISTEN)

    if [[ -n "$process" ]]; then
        echo "Killing $(echo "$process" | awk '{ print $1 }')"
        echo "$process" | awk '{ print $2 }' | xargs kill
    else
        echo "No process running on port $port"
    fi
}

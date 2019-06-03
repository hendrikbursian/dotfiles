#! /usr/bin/env bash

function __set_transparency() {
    local transparency=$1
    
    [[ -n "$transparency" ]] || transparency=90

    sh -c "xprop -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $(printf 0x%x $((0xffffffff * transparency / 100)))"
}
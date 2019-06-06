#! /usr/bin/env bash

# vscode
alias c='code'

# git
alias grb='git rebase -i origin/develop'
alias gdev='git checkout develop && git pull'
alias gpf='git push --force-with-lease'
alias gcf='git commit --fixup'
alias gs='git status'
alias gwip='git add && git commit -m "WIP"'

# transparency
alias tr='__set_transparency'

# kill process on port
function __killport {
    kill "$(sudo lsof -t -i:"$1")";
}
alias killport='__killport'

# copy to clipboard
alias clip='xclip -sel clip<<<'

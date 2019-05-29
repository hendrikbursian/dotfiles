#! /usr/bin/env bash

# antibody
alias plug='__load_plugins'

# vscode
alias c='code'

# git
alias grb='git rebase -i origin/develop'
alias gdev='git checkout develop && git pull'
alias gpf='git push --force-with-lease'
alias gcf='git commit --fixup'

# transparency
alias tr='__set_transparency'

# kill process on port
alias killport='sudo kill $(sudo lsof -t -i:8080)'
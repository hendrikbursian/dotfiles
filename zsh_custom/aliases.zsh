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
alias killport='__killport'

# copy to clipboard
alias clip='xclip -sel clip<<<'

# activate virtual env in python project
alias a='source */bin/activate'

# make executable
alias x='chmod +x'

# load env files
alias lenv='source .env.* && echo "Environment loaded"'

# timers
alias coffee='termdown -bs -T "Coffee! :)" -c 20 5m'
alias t1='termdown -bs -t "Check your path" -c 150 15m'
alias t2='termdown -bs -t "Check your path" -c 300 30m'
alias t3='termdown -bs -t "Check your path" -c 600 60m'
alias t4='termdown -bs -t "Check your path" -c 900 90m'

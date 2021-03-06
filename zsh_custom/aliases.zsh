#! /usr/bin/env bash

# vscode
alias c='code-insiders'

# git
alias gdev='git checkout develop && git pull'
alias gcf='git commit --fixup'
alias gs='git status'
alias gwip='git add . && git commit -m "WIP"'
alias gu='git undo'

# copy to clipboard
alias clip='xclip -sel clip<<<'
alias clipfile='xclip -selection clip'

# Screenshots
alias ssareafile='import $HOME/Desktop/screenshot.png'
alias ssareaclip='import /tmp/screenshot.png && xclip -sel clip -t image/png /tmp/screenshot.png'

# activate virtual env in python project
alias a='source */bin/activate'

# make executable
alias x='chmod +x'

# timers
alias coffee='termdown -bs -T "Coffee! :)" -c 20 5m'
alias t1='termdown -bs -t "Check your path" -c 150 15m'
alias t2='termdown -bs -t "Check your path" -c 300 30m'
alias t3='termdown -bs -t "Check your path" -c 600 60m'
alias t4='termdown -bs -t "Check your path" -c 900 90m'

# selenium
alias sel='docker run --rm --network host --shm-size=512m selenium/standalone-chrome'
alias selui='docker run --rm --network host --shm-size=512m --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --env="DISPLAY" selenium/standalone-chrome'

# stop all docker containers
alias docksall='docker stop $(docker ps -aq)'

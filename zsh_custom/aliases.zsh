# Git
alias grb="git rebase -i origin/develop"
alias gco='function __commitall(){ git commit -a -m $1; }; __commitall'
alias gcoa='function __commitall(){ git commit --amend -a; }; __commitall'
alias gdev='git checkout develop && git pull'
alias gpf='git push --force-with-lease'
alias gre='git checkout origin/develop'

# Wobcom
alias bmock='/home/hendrik/workspace/cssp/abestmockadapter/contrib/build.ps1'
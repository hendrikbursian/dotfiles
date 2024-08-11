function git-fetch-worktree() {
	git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
	git fetch
}

function git-add-worktree() {
	git worktree add "$1"
	cd "$1" || true
}

function git-rebase-interactive-branch-root() {
	git rebase --interactive "$(git log $(git remote show origin | sed -n '/HEAD branch/s/.*: //p')..$(git branch --show-current) --oneline | tail -1 | awk '{ print $1 }')"~1
}

function kill-port() {
    pids=$(lsof -i ":$1" | tail -n+2 | awk '{ print $2 }')
    errcode=$?
    if [[ $errcode -ne 0 ]] || [[ "$pids" == "" ]]; then
        echo "No processes found"
        return
    fi

    kill -9 "$pids"
}

# Template function for starting services
#
#  function _dev() {
# 	services=("api" "frontend")
# 	selected_services=($(echo "${services[@]}" | tr ' ' '\n' | fzf --multi))

#     # docker_services=("mail")
# 	# selected_docker_services=($(echo "${docker_services[@]}" | tr ' ' '\n' | fzf --multi))

# 	tmux new-window -n "node"
# 	for service in "${selected_services[@]}"; do
#         case "$service" in
#             "api")
#                 PORT=3000
#                 DEBUG_PORT=9220
#             ;;
#             # "api")
#             #     PORT=3000
#             #     DEBUG_PORT=9220
#             # ;;
#             *) echo "no port set for $service"
#             ;;
#         esac    
# 		# tmux send-keys "PORT=$PORT yarn start --watch --debug $DEBUG_PORT $service" C-m
# 		tmux split-window -v
# 	done

#     # tmux send-keys "yarn frontend/ serve"
#     # tmux split-window -v
#     # tmux send-keys "yarn start-another-service" C-m

#     # if [[ -z ${selected_docker_services[0]} ]]; then
#     #     tmux new-window -n "docker"
#     #     tmux send-keys "docker compose --file docker-compose.yml up $selected_docker_services" C-m
#     # fi
# }

#! /usr/bin/env zsh
#TODO ADD TSLINTPLUGIN TO INTSAALLATOIN
# TERMINAL TOGGL
#
# This plugin is used to start toggl entries depending on the branch that is currently checked out.
#
# The title of the time entry is determined in the following sequence
#   1. Branch name contains issue id -> Fetch title from issue
#   2. Branch has related merge request(s) -> Look for related issue(s) and fetch title
#   3. Branch has no relations -> Ask for title
#
# Tested on ubuntu 18.04

gitlab_url=
gitlab_token=
gitlab_project_id=
toggl_token=
toggl_project_id=

choose_from_related_issues() {
    issues_response=$(curl -sL --url "$gitlab_url/api/v4/projects/$gitlab_project_id/merge_requests/$merge_request_id/closes_issues" --header "PRIVATE-TOKEN: $gitlab_token")
    issues=$(echo "$issues_response" | jq --raw-output '.[] | "\(.iid)\t\(.title)"')

    issues_count=$(wc -l <<<"$issues")

    if [[ "$issues_count" == 0 ]]; then
        echo "I couldn't find an issue related to merge request with id $merge_request_id. I'll use the title from the merge request."

        merge_request_title=$(
            # Extract and clean title
            echo "$merge_requests_response" | jq --raw-output --arg id "$merge_request_id" 'map(select(.iid == ($id | tonumber)))[0].title' |
                sed s/^WIP:\ // |
                sed s/^Resolve\ \"// |
                sed s/\"$//
        )
        toggl_entry_title="!$merge_request_id $merge_request_title"
    elif [[ "$issues_count" == 1 ]]; then
        toggl_entry_title=$(echo "$issues_response" | jq --raw-output '.[0] | "#\(.iid) \(.title)"')
    else
        echo "I found multiple issues for merge request with id $merge_request_id."
        echo ""
        echo -e "id\ttitle"
        echo -e "----\t--------------------------"
        echo "$issues"
        echo ""
        printf "What issue are you working on? (id) "
        read -r issue_id

        toggl_entry_title=$(echo "$issues_response" | jq --raw-output --arg id "$issue_id" 'map(select(.iid == ($id | tonumber)))[0] | "#\(.iid) \(.title)"')
    fi
}

choose_from_related_merge_requests() {
    echo "I couldn't find an issue related to your branch and looked for merge requests instead."
    echo ""
    echo -e "id\ttitle"
    echo -e "----\t--------------------------"
    echo "$merge_requests"
    echo ""
    printf "What merge request are you working on? (id) "
    read -r merge_request_id
}

start_time_entry() {
    curl -s \
        -u "$toggl_token\:api_token" \
        -X POST https://www.toggl.com/api/v8/time_entries/start \
        -H "Content-type: application/json" \
        -d "{\"time_entry\":{\"description\":\"$toggl_entry_title\",\"tags\":[],\"pid\":$toggl_project_id}}" | jq
}

start() {
    toggl_entry_title=$1

    if [[ -n "$toggl_entry_title" ]]; then
        git_origin_url=$(git config --get remote.origin.url)

        if [[ "$git_origin_url" == "git@$gitlab_url"* ]]; then
            branch_name=$(git rev-parse --abbrev-ref HEAD)
            issue_id=$(echo "$branch_name" | grep -o -E '^[0-9]+')

            if [[ -z "$issue_id" ]]; then
                echo "test"
                merge_requests_response=$(curl -sL --url "$gitlab_url/api/v4/projects/$gitlab_project_id/merge_requests?source_branch=$branch_name" --header "PRIVATE-TOKEN: $gitlab_token")
                merge_requests=$(echo "$merge_requests_response" | jq --raw-output '.[] | "\(.iid)\t\(.title)"')
                merge_request_count=$(wc -l <<<"$merge_requests")

                if [[ "$merge_request_count" == 0 ]]; then
                    echo "I couldn't find issues or merge requests related to your branch. What title do you wish for your time entry?"
                    read -r toggl_entry_title
                elif [[ "$merge_request_count" == 1 ]]; then
                    merge_request_id=$(echo "$merge_requests_response" | jq --raw-output '.[0].iid')
                    choose_from_related_issues
                else
                    choose_from_related_merge_requests
                    choose_from_related_issues
                fi
            else
                toggl_entry_title=$(curl -sL --url "$gitlab_url/api/v4/projects/$gitlab_project_id/issues/$issue_id" --header "PRIVATE-TOKEN: $gitlab_token" | jq --raw-output '"#\(.iid) \(.title)"')
            fi

        else
            echo "I didn't find a valid repository. Please type a title for your time entry to get started."
            read -r toggl_entry_title
        fi
    else
        echo "No related issue or merge request found. Please enter a title for your time entry to get started"
        read -r toggl_entry_title
    fi

    echo "Alright, starting a timer with title '$toggl_entry_title'"
    start_time_entry
}

alias t='start'

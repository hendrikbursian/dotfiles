#!/usr/bin/env zsh
function toggl() {
    RESULT=$(
        # TODO LOCAL API KEY
        curl -u "$TOGGL_API_TOKEN":api_token -s -X GET \
        "https://toggl.com/reports/api/v2/weekly?user_agent=toggl-plugin-zsh&workspace_id=$TOGGL_WORKSPACE_ID&project_ids=$TOGGL_PROJECT_IDS&api_token=$TOGGL_API_TOKEN" \
        -H 'Content-Type: application/json'
    )
    printf '%s' $RESULT
}

alias toggl=toggl
#!/usr/bin/env sh
i3-msg -t get_workspaces | jq -r 'map(.name)' | sed 's/[]"\[, ]//g;/^$/d'


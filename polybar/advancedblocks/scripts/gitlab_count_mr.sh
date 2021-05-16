#!/bin/sh
set -eu

source ~/.minimicsrc

# Count MRs for a specified gitlab project
# $1 is the project or group name
count_mr ()
{
	# Count Merge Requests with label "Ready For Review"
  review_count=$(curl -sf "${MINIMICS_GITLAB_API_URL}/${1}/merge_requests?scope=all&state=opened&wip=no&labels=ready%20for%20review&view=simple&private_token=${MINIMICS_GITLAB_PRIVATE_TOKEN}" | jq length)

	# Count Merge Requests with label "Ready For Merge"
  merge_count=$(curl -sf "${MINIMICS_GITLAB_API_URL}/${1}/merge_requests?scope=all&state=opened&wip=no&labels=ready%20for%20merge&view=simple&private_token=${MINIMICS_GITLAB_PRIVATE_TOKEN}" | jq length)

  echo " ${review_count}  ${merge_count}"
}

count_mr ${MINIMICS_GITLAB_PROJECT}

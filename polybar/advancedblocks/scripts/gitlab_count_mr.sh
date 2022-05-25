#!/bin/sh
set -eu

source ~/.minimicsrc

# Count MRs for a specified gitlab project
# $1 is the project or group name
count_mr ()
{
	# Count Merge Requests with label "Ready For Review"
  review_count=$(curl -sf -H "x-per-page: 99" -H "PRIVATE-TOKEN: ${MINIMICS_GITLAB_PRIVATE_TOKEN}" "${MINIMICS_GITLAB_API_URL}/${1}/merge_requests/?scope=all&state=opened&draft=no&labels=status%3A%3Aready%20for%20review&view=simple" | jq length)

	# Count Merge Requests with label "Ready For Merge"
  merge_count=$(curl -sf  -H "x-per-page: 99" -H "PRIVATE-TOKEN: ${MINIMICS_GITLAB_PRIVATE_TOKEN}" "${MINIMICS_GITLAB_API_URL}/${1}/merge_requests?scope=all&state=opened&draft=no&labels=status%3A%3Aready%20for%20merge&view=simple" | jq length)

  echo " ${review_count}  ${merge_count}"
}

count_mr ${MINIMICS_GITLAB_PROJECT}

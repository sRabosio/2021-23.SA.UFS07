#!/bin/bash

set -e

date

# this exit with 1 if no auth configured
gh auth status

# env passed by GitHub Action environment

if [ -z "${GITHUB_REF_NAME}" ];
then
    echo "env GITHUB_REF_NAME is empty"
    exit 1
fi

if [ -z "${GITHUB_API_URL}" ];
then
    echo "env GITHUB_API_URL is empty"
    exit 1
fi

if [ -z "${GITHUB_REPOSITORY}" ];
then
    echo "env GITHUB_REPOSITORY is empty"
    exit 1
fi

# retrieve pr id
IFS=$'\/' read -r prId _ <<< $GITHUB_REF_NAME
echo "prId $prId"

ghApiGetReviews="$GITHUB_API_URL/repos/$GITHUB_REPOSITORY/pulls/$prId/reviews"
echo "ghApiGetReviews: $ghApiGetReviews"
gh api --method GET $ghApiGetReviews | jq '.' > ghApiGetReviewsResponse.ignore.json

changesRequestedUrls=`cat ghApiGetReviewsResponse.ignore.json | jq -r '. | map(select(.state | contains ("CHANGES_REQUESTED"))) | .[] .html_url'`
jq -ncR '[inputs]' <<< $changesRequestedUrls | jq '[ .[] | select(length > 0) ]' > changesRequestedUrls.ignore.json

cat changesRequestedUrls.ignore.json

changesRequestedCount=`cat changesRequestedUrls.ignore.json | jq '. | length'`
if [ "$changesRequestedCount" -ne "0" ];
then
    echo "There are CHANGES REQUESTED ON THIS PR"

    gh pr edit $prId --add-label "CHANGES_REQUESTED"
else
    gh pr edit $prId --remove-label "CHANGES_REQUESTED"
fi

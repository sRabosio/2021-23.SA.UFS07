#!/bin/bash

set -e

date

# this exit with 1 if no auth configured
gh auth status

# env passed by GitHub Action environment
# GITHUB_REF_NAME="master"
# SOURCE_RUN_WORKFLOW_ID=2259649471
# GITHUB_API_URL="https://api.github.com"
# GITHUB_REPOSITORY="ITSRizzoli/2021-23.SA.UFS07"


if [ -z "${GITHUB_REF_NAME}" ];
then
    echo "env GITHUB_REF_NAME is empty"
    exit 1
fi
echo "GITHUB_REF_NAME is $GITHUB_REF_NAME"


if [ -z "${SOURCE_RUN_WORKFLOW_ID}" ];
then
    echo "env SOURCE_RUN_WORKFLOW_ID is empty"
    exit 1
fi
echo "SOURCE_RUN_WORKFLOW_ID: $SOURCE_RUN_WORKFLOW_ID"

gh run download $SOURCE_RUN_WORKFLOW_ID
SOURCE_RUN_WORKFLOW_GITHUB_REF_NAME=`grep -oP "GITHUB_REF_NAME=\K.*" trigger_envs/trigger_envs.txt`
echo "SOURCE_RUN_WORKFLOW_GITHUB_REF_NAME is $SOURCE_RUN_WORKFLOW_GITHUB_REF_NAME"

IFS=$'\/' read -r prId _ <<< $SOURCE_RUN_WORKFLOW_GITHUB_REF_NAME
echo "prId $prId"

if [ -z "${GITHUB_API_URL}" ];
then
    echo "env GITHUB_API_URL is empty"
    exit 1
fi
echo "GITHUB_API_URL is $GITHUB_API_URL"

if [ -z "${GITHUB_REPOSITORY}" ];
then
    echo "env GITHUB_REPOSITORY is empty"
    exit 1
fi
echo "GITHUB_REPOSITORY is $GITHUB_REPOSITORY"


ghApiGetReviews="$GITHUB_API_URL/repos/$GITHUB_REPOSITORY/pulls/$prId/reviews"
echo "ghApiGetReviews: $ghApiGetReviews"
gh api --method GET $ghApiGetReviews | jq '.' > ghApiGetReviewsResponse.ignore.json

lastReviewState=`cat ghApiGetReviewsResponse.ignore.json | jq -r '. | last | .state'`
echo "lastReviewState: $lastReviewState"

if [ "$lastReviewState" != "APPROVED" ];
then
    echo "There are CHANGES REQUESTED ON THIS PR"

    gh pr edit $prId --add-label "CHANGES_REQUESTED"
else
    gh pr edit $prId --remove-label "CHANGES_REQUESTED"
fi

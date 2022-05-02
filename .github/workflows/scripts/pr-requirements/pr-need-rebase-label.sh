#!/bin/bash

set -e

date

# this exit with 1 if no auth configured
gh auth status

# env passed by GitHub Action environment
# GITHUB_REF_NAME="18/merge"

if [ -z "${GITHUB_REF_NAME}" ];
then
    echo "env GITHUB_REF_NAME is empty"
    exit 1
fi

if [ -z "${SOURCE_RUN_WORKFLOW_ID}" ];
then
    echo "env SOURCE_RUN_WORKFLOW_ID is empty"
    exit 1
fi
echo "SOURCE_RUN_WORKFLOW_ID: $SOURCE_RUN_WORKFLOW_ID"

echo "waiting for source workflow finishes...."
gh run watch $SOURCE_RUN_WORKFLOW_ID

gh run download $SOURCE_RUN_WORKFLOW_ID
SOURCE_RUN_WORKFLOW_GITHUB_REF_NAME=`grep -oP "GITHUB_REF_NAME=\K.*" trigger_envs/trigger_envs.txt`
echo "SOURCE_RUN_WORKFLOW_GITHUB_REF_NAME is $SOURCE_RUN_WORKFLOW_GITHUB_REF_NAME"

IFS=$'\/' read -r prId _ <<< $SOURCE_RUN_WORKFLOW_GITHUB_REF_NAME
echo "prId $prId"

# retrieve if is behind
# https://docs.github.com/en/github-ae@latest/graphql/reference/enums#mergestatestatus

prMergeStateStatus=`gh pr view $prId --json mergeStateStatus | jq -r '.mergeStateStatus'`
echo "prMergeStateStatus: $prMergeStateStatus"

while [ "$prMergeStateStatus" = "UNKNOWN" ]
do
    echo "prMergeStateStatus UNKNOWN retry in 5s..."
    sleep 5
    prMergeStateStatus=`gh pr view $prId --json mergeStateStatus | jq -r '.mergeStateStatus'`
    echo "prMergeStateStatus: $prMergeStateStatus"
done

if [ "$prMergeStateStatus" = "BEHIND" ];
then
    echo "The source branch of this PR is BEHIND"

    gh pr edit $prId --add-label "NEED_REBASE"
else
    gh pr edit $prId --remove-label "NEED_REBASE"
fi

# same for mergeable status
# https://docs.github.com/en/github-ae@latest/graphql/reference/enums#mergeablestate

prMergeable=`gh pr view $prId --json mergeable | jq -r '.mergeable'`
echo "prMergeable: $prMergeable"

while [ "$prMergeable" = "UNKNOWN" ]
do
    echo "prMergeable UNKNOWN retry in 5s..."
    sleep 5
    prMergeable=`gh pr view $prId --json mergeable | jq -r '.mergeable'`
    echo "prMergeable: $prMergeable"
done

if [ "$prMergeStateStatus" = "CONFLICTING" ];
then
    echo "There are conflicts!!"

    gh pr edit $prId --add-label "HAS_CONFLICTS"
else
    gh pr edit $prId --remove-label "HAS_CONFLICTS"
fi

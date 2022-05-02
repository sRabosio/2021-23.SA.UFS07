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

# retrieve pr id
IFS=$'\/' read -r prId _ <<< $GITHUB_REF_NAME
echo "prId $prId"

prMergeStateStatus=`gh pr view $prId --json mergeStateStatus | jq -r '.mergeStateStatus'`
echo "prMergeStateStatus: $prMergeStateStatus"

while [ "$prMergeStateStatus" = "UNKNOWN" ]
do
    echo "mergeStateStatus unkown retry in 5s..."
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

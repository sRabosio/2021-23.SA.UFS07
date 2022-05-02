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

# fetch more commits
prCommits=`gh pr view $prId --json commits | jq '.commits | length'`
echo "prCommits: $prCommits"
fetchDepthToPrBase=`expr $prCommits + 2`
echo "fetchDepthToPrBase: $fetchDepthToPrBase"
git fetch --no-tags --prune --no-recurse-submodules --deepen=$fetchDepthToPrBase
git log -${fetchDepthToPrBase}

# retrive the pr first commit
prFirstCommitSha=`gh pr view $prId --json commits | jq -r '.commits | first | .oid'`
echo "prFirstCommitSha: $prFirstCommitSha"

# retrieve the pr base commit
prBaseSha=`git rev-parse $prFirstCommitSha^`
echo "prBaseSha: $prBaseSha"

set +e
# check every commit message from the prBaseSha
npm run commitlint -- -V --from $prBaseSha
lintStatus=$?
set -e

lintStatus=$?

if [ "$lintStatus" -ne "0" ];
then
    echo "There are commits that do not respect convetional commits"
    gh pr edit $prId --add-label "NOT_CONVENTIONAL_COMMITS"
    exit 1
else
    gh pr edit $prId --remove-label "NOT_CONVENTIONAL_COMMITS"
fi

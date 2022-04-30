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

# fetch more commits
prCommits=`gh pr view $prId --json commits | jq '.commits | length'`
fetchDepthToPrBase=`expr $prCommits + 2`
git fetch --no-tags --prune --no-recurse-submodules --deepen=$fetchDepthToPrBase

# retrive the pr first commit
prFirstCommitSha=`gh pr view $prId --json commits | jq -r '.commits | first | .oid'`
echo "prFirstCommitSha: $prFirstCommitSha"

# retrieve the pr base commit
prBaseSha=`git rev-parse $prFirstCommitSha^`
echo "prBaseSha: $prBaseSha"

# check every commit message from the prBaseSha
npm run commitlint -- -V --from $prBaseSha

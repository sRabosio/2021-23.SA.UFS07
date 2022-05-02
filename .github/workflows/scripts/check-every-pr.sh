#!/bin/bash

set -e

date

scriptsFolder=`dirname $0`

gh pr list --json number | \
    jq -r '.[] | .number' | \
    while read -r prId;
    do
        gh pr view $prId
        GITHUB_API_URL=https://api.github.com PR_ID=$prId GITHUB_REPOSITORY="ITSRizzoli/2021-23.SA.UFS07" $scriptsFolder/pr-chages-requested-label.sh
        GITHUB_API_URL=https://api.github.com PR_ID=$prId GITHUB_REPOSITORY="ITSRizzoli/2021-23.SA.UFS07" $scriptsFolder/pr-requirements/pr-need-rebase-label.sh
    done

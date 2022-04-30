# PR requirements

Inside this folder there are some utils used by the teacher to check students PR.

We use something like CI for checking assignment status.

## using updatedAt

Seems that updatedAt is bugged (returns same time for every PR)

`gh pr  list --json baseRefName --json author --json updatedAt --json title | jq -r '.[] | (.updatedAt + " - (" + .title + ") https://github.com/" + .author.login + "/2021-23.SA.UFS07/commits")' | sort`

## using search
`gh search prs --sort updated --order desc --repo ITSRizzoli/2021-23.SA.UFS07 --state open`

# Last workflow statues for every PR

`gh pr list --json baseRefName --json author --json updatedAt --json title | jq -r '.[] | (.author.login + "/2021-23.SA.UFS07")' | while read -r repo; do gh run list --repo $repo --limit 1 --json conclusion --json updatedAt --json status --json url | jq -r '.[] | (.updatedAt + " - (" + .status + " with "+ .conclusion +") " + .url)'; done | sort`

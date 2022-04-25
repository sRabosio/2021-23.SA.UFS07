# 4 fork, branch and commit

## Enable GitHub sidebar

Click the GitHub sidebar, GitPod will ask some authorization and it will fail.

![29-enable-github-sidebar](images/29-enable-github-sidebar.png)

We need to go on https://gitpod.io/integrations and edit the permission on the GitHub integration.

![30-edit-gitpod-github-integration](images/30-edit-gitpod-github-integration.png)

selecting permission as follow

![31-permission-for-gitpod-github-integration](images/31-permission-for-gitpod-github-integration.png)

click _Update permissions_ and go back to the GitHub sidebar on your GitPod.

Now it'll go straight and show your GitHub Pull Requests and Issues for this repo (nothing for now).

## GitHub CLI login

To fork a repo we can do it from the GitHub interface or from the GitHub CLI.

We'll use the GitHub CLI :)

So to start we need to login on the GitHub CLI, type `gh auth login` in the VSCode terminal and answer as follow

![32-gh-auth-login](images/32-gh-auth-login.png)

### Create the token for the GitHub CLI login

Open https://github.com/settings/token as suggested by the CLI message then

![33-gh-auth-generate-token](images/33-gh-auth-generate-token.png)

then select permissions

![34-gh-auth-generate-token-select-permission](images/34-gh-auth-generate-token-select-permission.png)

finally paste the token to the CLI.

## Repo fork with the GitHub CLI

Simple type `gh repo fork` in the terminal.

![35-gh-repo-fork](images/35-gh-repo-fork.png)

**From now the new default remote repository is our fork.**

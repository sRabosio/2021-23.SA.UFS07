# 3 GitLens command palette

## opening the palette

When we press CTRL+SHIFT+G in the bottom status bar of VSCode will appear a message "waiting for a chord..."

![19-waitig-for-a-chord](images/19-waitig-for-a-chord.png)

our chord for opening the palette is /

![20-git-lens-command-palette](images/20-git-lens-command-palette.png)

## search commits

typing "searc" the palette will do a filter on commands, selecting _search_ and press ENTER we can able to enter the search submenu

from the search submenu we can choose "Search by message" and then use "feat" as a search string to find every commit that have "feat" in the message

![21-search-by-message-feat](images/21-search-by-message-feat.png)

we can also search by file, for example looking for every commit that have edited any md file with `*.md`

![21-search-by-file-md](images/21-search-by-file-md.png)

or we can search by changes refining to every commit that have change a specific text, for example every commit that have introduced or removed `<img` html tags

![22-search-by-change-html-img-tag](images/22-search-by-change-html-img-tag.png)


## status

the status command will show fi we have changes in our working directory and if we have commits that aren't pushed to the remote

## history

the history command is useful to navigate and full text search inside branches, tags and commits

open the history command
![23-history](images/23-history.png)

search for branch that have "feature" in the branch name
![24-history-branch-with-feature-name](images/24-history-branch-with-feature-name.png)

search for commits that have "switch" in the message
![25-history-commit-with-switch-message](images/25-history-commit-with-switch-message.png)

when we reach the last commit menu' we can do a lot of things for example show the commit in the sidebar

![26-history-commit-details](images/26-history-commit-details.png)

## stash

the stash action put aside every change we haven't commited yet.

Is very useful to save something we didn't want to commit but also we didn't want to lose

Give a try editing a file, save it and then use the GitLens palette to stash changes.

After we select _stash_ from the palette we'll ask which stash operation
- push means create a new stash
- list means list all saved stash
- apply means apply change from a stash to our working directory
- drop means delete a stash
- pop means apply change from a stash and remove the stash from the stash list

in our case we want to push a stash
![27-stash-push](images/27-stash-push.png)

now the command palette ask us something about the push operation, we'll select the first that act as follow
- save changes in the stash
- remove changes from our working directory

as we can see there are other options available
![27-stash-push-options](images/27-stash-push-options.png)

after we pushed a stash we can see it from the sidebar
![28-stash-sidebar](images/28-stash-sidebar.png)

# NEXT: fork the repo and commit something

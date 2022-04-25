# Auto generate a CHANGELOG oh yeah

To do this we're using https://github.com/conventional-changelog/standard-version

In this folder standard-version is just configured so we only need to install deps before continue

`npm install`

Simply execute in this folder

`npm run release`

and follow instruction on screen.

**NB: we dind't publish any npm package so the `npm publish` command is not for us for now.**

After you have push your tag to you repo you can create a GitHub release following those steps

https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository#creating-a-release

You can use the source of the generated CHANGELOG.md to copy/paste release notes.

(obv we can automate this using for example https://github.com/google-github-actions/release-please-action but for now let's do it by hand)

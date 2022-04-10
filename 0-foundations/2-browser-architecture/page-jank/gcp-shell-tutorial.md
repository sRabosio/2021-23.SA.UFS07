# UFS07 render vs compositor!!!

Welcome to the shell!

## Next steps

1. Start a web server
2. Open the page
3. Update our JS to avoid Page Jank

## Start a web server

```sh
python -m SimpleHTTPServer 8080
```

## Open the page

Click <walkthrough-web-preview-icon></walkthrough-web-preview-icon>.

and click the first two paragraphs to start animations, then click the third one.

Look at animations: one is blocked by JS executed by the last paragraph clicked.
That's a Page Jank!!

## Update our JS to avoid Page Jank

Now follow the link "request-idle-callback.html" at the top of the page

Try again both animations, they are smooth!

### BONUS TRACK: high quality JS code

How our JS can make it happen?

We need generate the docs to discover how!

First stop the web server with CTRL+C

Then generate docs

```sh
npx -y jsdoc -d docs request-idle-callback.js
```

now we can restart our web server

```sh
python -m SimpleHTTPServer 8080
```

and click the "docs" link at the top of the "request-idle-callback.html" page.

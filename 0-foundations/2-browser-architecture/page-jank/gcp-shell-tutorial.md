# UFS07 render vs compositor!!!

Welcome to the shell!

## Next steps

1. Start a web server
2. Open the page
3. Profile with Chrome DevTools

## Start a web server

```sh
python -m SimpleHTTPServer 8080
```

## Open the page

Click <walkthrough-web-preview-icon></walkthrough-web-preview-icon>.

and click the first two paragraphs to start animations, then click the third one.

Look at animations: one is blocked by JS executed by the last paragraph clicked.
That's a Page Jank!!

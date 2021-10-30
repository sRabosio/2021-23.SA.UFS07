# UFS07 HTTP take it easy!!!

Welcome to the shell!

## Next steps

1. Install netcat
2. Create a FIFO pipe and start the web server on port 8080
3. Connect the browser to the web server
4. Send the http message on the fifo stream
5. Close che connection stopping netcat

## Install netcat

netcat is the TCP/IP swiss army knife :)

```sh
sudo apt-get install -y netcat
```

## Create a FIFO pipe

mkfifo create a file handler that act as a FIFO pipe

```sh
mkfifo /tmp/fifo-pipe
```
### Split terminal windows using tmux

```sh
tmux split-window
```

now you can switch between terminal window using

CTRL+B __then__ ↑

or

CTRL+B __then__ ↓

### Start the web server on port 8080

forward every line that enter the FIFO pipe to netcat web server that listen on port 8080

```sh
tail -f /tmp/fifo-pipe | nc -l -p 8080
```

## Connect the browser to the web server

Click <walkthrough-web-preview-icon></walkthrough-web-preview-icon>.

If everything is fine you'll see the browser loading __infinitly__, leave it loading :)

On the terminal where the netcat server is running you'll see the whole HTTP request sent by the browser.

<walkthrough-footnote>
Until the server close the connection the browser will remain in loading state.
</walkthrough-footnote>

## Send the http message on the FIFO pipe

Leaving netcat running, use tmux to switch to the other terminal and sen the http message on the FIFO pipe 

```sh
cat http-response.txt >> /tmp/fifo-pipe
```

The above command will send our <walkthrough-editor-open-file filePath="http-response.txt">http-response.txt</walkthrough-editor-open-file> to the FIFO pipe, the tail -f command will copy data in the pipe to the netcat web server and finally to the browser!

<walkthrough-footnote>
you can switch between terminal window using

CTRL+B __then__ ↑

or

CTRL+B __then__ ↓
</walkthrough-footnote>

## Close the connection stopping netcat

Switch to the terminal tab where netcat is running and press CTRL+C to stop it.

Check the browser!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

<walkthrough-footnote>
you can switch between terminal window using

CTRL+B __then__ ↑

or

CTRL+B __then__ ↓
</walkthrough-footnote>

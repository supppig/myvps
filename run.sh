#!/bin/bash

cd /root/kcp
nohup ./server_linux_amd64 -c kcp-server.json >/dev/null &
sleep 1
nohup ss-server -s 0.0.0.0 -p 8388 -k supppig -m rc4-md5 >/dev/null &
sleep 1
#nohup /root/doloop.sh >/dev/null &
sleep 1
/usr/sbin/sshd -D

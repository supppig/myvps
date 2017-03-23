#!/bin/bash

cd /root/kcp
nohup ./server_linux_amd64 -c kcp-server.json >/dev/null &

nohup ss-server -s 0.0.0.0 -p 8388 -k supppig -m rc4-md5 >/dev/null &

/usr/sbin/sshd -D

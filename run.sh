#!/bin/bash

cd /root/kcp
nohup ./server_linux_amd64 -c kcp-server.json >/dev/null &

cd /root/ssr
python ./shadowsocks/server.py -d start

/usr/sbin/sshd -D

#!/bin/bash
cd /root
url=$(wget -q -O- https://api.github.com/repos/xtaci/kcptun/releases/latest | grep "rowser_download_url" | grep "linux-amd64" | cut -d'"' -f4)
echo $url
wget -O kcp.tar.gz ${url}
tar zxvf kcp.tar.gz
ls
echo "OK"


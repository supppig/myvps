#!/bin/bash
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
cd /root/kcp
url=$(wget -q -O- https://api.github.com/repos/xtaci/kcptun/releases/latest | grep "rowser_download_url" | grep "linux-amd64" | cut -d'"' -f4)
wget -q -O kcp.tar.gz ${url}
tar zxvf kcp.tar.gz

#!/bin/bash

#SSH
/usr/sbin/sshd -D

#KCP
cd /root
mkdir kcp
cd kcp
url=`wget -q -O- https://api.github.com/repos/xtaci/kcptun/releases/latest | grep -m1 'assets_url' | cut -d'"' -f4`
downloadurl=`wget -q -O- $url | grep 'browser_download_url' | grep 'linux-amd64' | cut -d'"' -f4`
wget -q -O kcp.tar.gz $downloadurl
tar zxf kcp.tar.gz
cat > kcp-server.json << 'EOF'
{
    "listen":":4000",
    "target":"127.0.0.1:8388",
	"key":"supppig",
	"crypt":"none",
	"mode":"fast",
	"nocomp":true
}
EOF
nohup ./server_linux_amd64 -c kcp-server.json >/dev/null &

#SSR
cd /root
git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git ssr
cd ssr
cp ./config.json ./user-config.json
sed -ri 's/^.*\"password\".*/    \"password\": \"supppig\",/' ./user-config.json
sed -ri 's/^.*\"method\".*/    \"method\": \"rc4-md5\",/' ./user-config.json
sed -ri 's/^.*\"protocol\".*/    \"protocol\": \"auth_sha1_v2_compatible\",/' ./user-config.json
sed -ri 's/^.*\"obfs\".*/    \"obfs\": \"http_simple_compatible\",/' ./user-config.json
sed -ri 's/^.*\"fast_open\".*/    \"fast_open\": false/' ./user-config.json
nohup python ./shadowsocks/server.py -d start

echo "OK"

#!/bin/bash

flashurl()
{
#刷刷网络
#https://www.google.com
#http://www.yahoo.com
#http://www.goo.ne.jp
#http://jp.msn.com
#http://allabout.co.jp
#http://www.ocn.ne.jp
#http://www.nifty.com
#http://www.biglobe.ne.jp
rdm=$(($RANDOM%8))
case $rdm in
0)
url="https://www.google.com"
;;
1)
url="http://www.yahoo.com"
;;
2)
url="http://www.goo.ne.jp"
;;
3)
url="http://jp.msn.com"
;;
4)
url="http://allabout.co.jp"
;;
5)
url="http://www.ocn.ne.jp"
;;
6)
url="http://www.nifty.com"
;;
7)
url="http://www.biglobe.ne.jp"
;;
esac
echo "wget $url"
wget -q -T10 -t1 -O- $url >/dev/null
}

while [[ 1 = 1 ]]
do
flashurl
sleep 590
done

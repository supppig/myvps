FROM       debian:latest
MAINTAINER supppig <supppig@gmail.com>

ENV KCPTUN_VERSION 20170303

RUN url=$(wget -q -O- https://api.github.com/repos/xtaci/kcptun/releases/latest | grep "rowser_download_url" | grep "linux-amd64" | cut -d'"' -f4)
RUN echo ${url}
RUN wget -O kcp.tar.gz ${url} 
#RUN tar -zxvf kcptun-linux-amd64-${KCPTUN_VERSION}.tar.gz
RUN tar zxvf kcp.tar.gz
RUN mv /root/kcp-server.json .

FROM       debian:latest
MAINTAINER supppig <supppig@gmail.com>

ENV KCPTUN_VERSION 20170303

COPY ./getkcp.sh /root/getkcp.sh
WORKDIR /root
RUN chmod 777 /root/getkcp.sh
RUN ./getkcp.sh

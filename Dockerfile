FROM       debian:latest
MAINTAINER supppig <supppig@gmail.com>

ENV KCPTUN_VERSION 20170303

RUN apt-get update && \
apt-get install -y wget

COPY ./getkcp.sh /root/getkcp.sh
WORKDIR /root
RUN chmod 777 /root/getkcp.sh
RUN ./getkcp.sh

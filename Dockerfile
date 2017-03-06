FROM       debian:latest
MAINTAINER supppig <supppig@gmail.com>

ENV KCPTUN_VERSION 20170303

# pre
RUN apt-get update && \
apt-get clean  && \
apt-get install -y openssh-server python python-pip python-m2crypto libnet1-dev libpcap0.8-dev git gcc wget && \
apt-get clean

cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY ./kcp-server.json /root/kcp-server.json
COPY ./run.sh /root/run.sh
RUN chmod 777 /root/run.sh

# ssh
RUN mkdir /var/run/sshd
RUN echo 'root:supppig' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
CMD    ["/usr/sbin/sshd", "-D"]

# SSR
RUN git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git ssr
RUN mv ssr /root/
WORKDIR /root/ssr
RUN cp ./config.json ./user-config.json
RUN sed -ri 's/^.*\"password\".*/    \"password\": \"supppig\",/' ./user-config.json
RUN sed -ri 's/^.*\"method\".*/    \"method\": \"rc4-md5\",/' ./user-config.json
RUN sed -ri 's/^.*\"protocol\".*/    \"protocol\": \"auth_sha1_v2_compatible\",/' ./user-config.json
RUN sed -ri 's/^.*\"obfs\".*/    \"obfs\": \"tls1.2_ticket_auth_compatible\",/' ./user-config.json

# KCPtun
RUN mkdir /root/kcp
WORKDIR /root/kcp
RUN wget https://github.com/xtaci/kcptun/releases/download/v${KCPTUN_VERSION}/kcptun-linux-amd64-${KCPTUN_VERSION}.tar.gz
RUN tar -zxvf kcptun-linux-amd64-${KCPTUN_VERSION}.tar.gz
RUN mv /root/kcp-server.json .

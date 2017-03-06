FROM       debian:latest
MAINTAINER supppig <supppig@gmail.com>

# pre
RUN apt-get update && \
apt-get clean  && \
apt-get install -y openssh-server python python-pip python-m2crypto git wget && \
apt-get clean

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir /root/kcp
COPY ./kcp-server.json /root/kcp/kcp-server.json
COPY ./getkcp.sh /root/kcp/getkcp.sh
RUN chmod 777 /root/kcp/getkcp.sh

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
WORKDIR /root/kcp
RUN bash ./getkcp.sh

ENTRYPOINT bash /root/run.sh

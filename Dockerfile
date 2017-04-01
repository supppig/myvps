FROM       debian:latest
MAINTAINER supppig <supppig@gmail.com>

# pre
RUN apt-get update
RUN apt-get install -y openssh-server python python-pip python-m2crypto git wget unzip
RUN apt-get install -y --no-install-recommends build-essential autoconf libtool libssl-dev gawk debhelper dh-systemd init-system-helpers pkg-config asciidoc xmlto apg libpcre3-dev
RUN apt-get clean

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir /root/kcp
COPY ./kcp-server.json /root/kcp/kcp-server.json
COPY ./getkcp.sh /root/kcp/getkcp.sh
RUN chmod 777 /root/kcp/getkcp.sh

COPY ./run.sh /root/run.sh
COPY ./doloop.sh /root/doloop.sh
RUN chmod 777 /root/*.sh

# ssh
RUN mkdir /var/run/sshd
RUN echo 'root:supppig' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
#CMD    ["/usr/sbin/sshd", "-D"]

# SSR
WORKDIR /root
RUN wget -O /root/libev.zip https://github.com/shadowsocksr/shadowsocksr-libev/archive/master.zip
RUN unzip libev.zip
RUN mv shadowsocksr-libev-master ssr
WORKDIR /root/ssr
#RUN dpkg-buildpackage -b -us -uc -i
#WORKDIR /root
#RUN dpkg -i shadowsocks-libev*.deb
RUN ./configure && make
RUN make install

# KCPtun
WORKDIR /root/kcp
RUN bash ./getkcp.sh

ENTRYPOINT bash /root/run.sh

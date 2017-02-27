FROM       ubuntu:16.04
MAINTAINER supppig <supppig@gmail.com>

ENV KCPTUN_VERSION 20170221

# pre
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y openssh-server python python-pip python-m2crypto libnet1-dev libpcap0.8-dev git gcc wget psmisc
RUN apt-get clean

# ssh
RUN mkdir /var/run/sshd
RUN echo 'root:supppig' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
CMD    ["/usr/sbin/sshd", "-D"]

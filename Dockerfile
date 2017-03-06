FROM       debian:latest
MAINTAINER supppig <supppig@gmail.com>

# pre
RUN apt-get update && \
apt-get install -y openssh-server

COPY ./test.sh /root/ttt.sh
RUN chmod 777 /root/ttt.sh

# ssh
RUN mkdir /var/run/sshd
RUN echo 'root:supppig' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
#CMD    ["/usr/sbin/sshd", "-D"]
ENTRYPOINT bash /root/ttt.sh

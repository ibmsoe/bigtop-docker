# Creates Bigtop base docker image
#
# 

FROM ubuntu:15.04
MAINTAINER Amir Sanjar
USER root

# install dev tools
RUN apt-get update && \
    apt-get install -qqy apt-utils sudo wget curl openjdk-8-jre libsnappy1 unzip  libsnappy-java openssl openssh-server openssh-client liblzo2-2 

# passwordless ssh
RUN yes | ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN yes | ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN yes | ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys   

# Add bigtop distribution repository
RUN wget -O- http://archive.apache.org/dist/bigtop/bigtop-1.1.0/repos/GPG-KEY-bigtop |  apt-key add - && \
    wget -O /etc/apt/sources.list.d/bigtop-1.1.0.list  http://www.apache.org/dist/bigtop/bigtop-1.1.0/repos/trusty/bigtop.list && \
    apt-get update 

CMD ["bash"]
EXPOSE 50020 50090 8020 50070 50010 50075 8031 8032 8033 8040 8042 49707 22 8088 8030

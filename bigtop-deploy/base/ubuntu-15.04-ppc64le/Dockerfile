# Creates Bigtop base docker image
#
# 

FROM bigtop/deploy:ubuntu-15.04-ppc64le
MAINTAINER Amir Sanjar
USER root

# install dev tools
RUN apt-get update && \
    apt-get install -qqy sudo wget curl openjdk-7-jre apt-utils libsnappy1 libsnappy-dev unzip libsnappy-java openssl openssh-server openssh-client liblzo2-2 

# passwordless ssh
RUN yes | ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN yes | ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN yes | ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys   

# Add bigtop distribution repository
RUN wget -O- http://archive.apache.org/dist/bigtop/bigtop-1.1.0/repos/GPG-KEY-bigtop |  apt-key add - && \
    wget -O /etc/apt/sources.list.d/bigtop-1.1.0.list  http://bigtop-repos.s3.amazonaws.com/releases/1.1.0/ubuntu/vivid/ppc64el/bigtop.list && \
    apt-get update && \
    apt-get install -yq bigtop-* hadoop-client hbase spark-*    

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

ADD install_bigtop_stack.sh /etc/install_bigtop_stack.sh
RUN chown root:root /etc/install_bigtop_stack.sh
RUN chmod 700 /etc/install_bigtop_stack.sh

CMD ["bash"]


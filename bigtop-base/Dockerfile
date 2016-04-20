# Creates Bigtop base docker image
#
# 

FROM ubuntu:14.04
MAINTAINER Amir Sanjar
USER root

# install dev tools
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y  ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -qqy sudo wget curl openjdk-8-jdk apt-utils libsnappy1 libsnappy-dev unzip libsnappy-java openssl openssh-server openssh-client liblzo2-2 

# passwordless ssh
RUN yes | ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN yes | ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN yes | ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys   

# Add bigtop distribution repository
RUN wget -O- http://archive.apache.org/dist/bigtop/bigtop-1.1.0/repos/GPG-KEY-bigtop |  apt-key add - && \
    wget -O /etc/apt/sources.list.d/bigtop-1.1.0.list  http://www.apache.org/dist/bigtop/bigtop-1.1.0/repos/trusty/bigtop.list && \
    apt-get update && \
    RUNLEVEL=1 apt-get install -y hadoop-client libhdfs_* 

ENV HADOOP_HOME /usr/lib/hadoop
ENV HADOOP_PREFIX $HADOOP_HOME
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_CONF_DIR /etc/hadoop/conf
ENV JAVA_HOME `find /usr/ -name java-8-openjdk-*`

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

ADD start_bigtop_services.sh /etc/start_bigtop_services.sh
RUN chown root:root /etc/start_bigtop_services.sh
RUN chmod 700 /etc/start_bigtop_services.sh

RUN echo "export JAVA_HOME=` find /usr/ -name java-8-openjdk-*`" |  tee -a  /etc/environment $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh && \
    echo "export HADOOP_CONF_DIR=/etc/hadoop/conf"  |  tee -a $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh && \
    echo "export HADOOP_PREFIX=/usr/lib/hadoop"  |  tee -a $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh  && \
    echo "export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec" | tee -a $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh && \
    echo "export HADOOP_LOGS=/usr/lib/hadoop/logs"  |  tee -a $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh && \
    echo "export HADOOP_COMMON_HOME=/usr/lib/hadoop" |  tee -a  $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh && \
    echo "export HADOOP_HDFS_HOME=/usr/lib/hadoop-hdfs" |  tee -a  $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh && \
    echo "export HADOOP_MAPRED_HOME=/usr/lib/hadoop-mapreduce" |  tee -a $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh && \
    echo "export HADOOP_YARN_HOME=/usr/lib/hadoop-yarn" |  tee -a $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh $HADOOP_PREFIX/etc/hadoop/yarn-env.sh
    
RUN  sed -i s/localhost/namenode/ /etc/hadoop/conf/core-site.xml && \
    # sed -i s/'Port 22'/'Port 2122'/ /etc/ssh/sshd_config && \
     chown -R $USER:hadoop /usr/lib/hadoop*  && \
     chown -R hdfs:hadoop /var/log/hadoop-hdfs*  && \
     chown -R yarn:hadoop /var/log/hadoop-yarn*  && \
     chown -R mapred:hadoop /var/log/hadoop-mapred*  && \
     chown -R $USER:hadoop /etc/hadoop


CMD ["bash"]
EXPOSE 50020 50090 50070 50010 50075 8031 8032 8033 8040 8042 49707 22 8088 8030

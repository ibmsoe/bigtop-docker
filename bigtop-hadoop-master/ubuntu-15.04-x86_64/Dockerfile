# Creates Bigtop base docker image
#
# 

FROM bigtop-hadoop-node:ubuntu-15.04-x86_64
MAINTAINER Amir Sanjar
USER root


RUN su hdfs -c "hdfs namenode -format"
   

CMD ["/etc/bigtop/start_bigtop_services.sh", "namenode", "resourcemanager"]
EXPOSE 50020 8020 50090 50070 50010 50075 8031 8032 8033 8040 8042 49707 22 8088 8030

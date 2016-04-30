# Creates Bigtop base docker image
#
# 

FROM bigtop-hadoop-node:ubuntu-15.04-x86_64
MAINTAINER Amir Sanjar
USER root

# install dev tools
RUN apt-get update && \
    RUNLEVEL=1 apt-get install -y spark-master 

RUN echo "export SPARK_MASTER_IP=`hostname`" | tee -a /etc/spark/conf/spark-env.sh && \
    cp /etc/spark/conf/spark-defaults.conf.template /etc/spark/conf/spark-defaults.conf && \
    echo "spark.master                     spark://"spark_master":7077" >>/etc/spark/conf/spark-defaults.conf && \
    echo "spark.eventLog.enabled           true" >>/etc/spark/conf/spark-defaults.conf && \
    echo "spark.eventLog.dir               hdfs://"spark_master":8020/directory" >>/etc/spark/conf/spark-defaults.conf && \
    cp /etc/spark/conf/log4j.properties.template /etc/spark/conf/log4j.properties && \
    echo "log4j.rootCategory=ERROR, console">>/etc/spark/conf/log4j.properties && \
    echo "spark.yarn.am.memory             1024m" >>/etc/spark/conf/spark-defaults.conf && \
    cp /etc/spark/conf/log4j.properties.template /etc/spark/conf/log4j.properties && \
    echo "log4j.rootCategory=ERROR, console">>/etc/spark/conf/log4j.properties


######update yarn-site.xml
RUN /etc/update-conf.sh
   
CMD ["/etc/start_bigtop_services.sh", "spark-master"]
EXPOSE 8080 7077 

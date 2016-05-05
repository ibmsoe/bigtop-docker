# Creates Bigtop zeppelin docker image
#
# 

FROM bigtop-hadoop-node:ubuntu-15.04-x86_64
MAINTAINER Amir Sanjar
USER root

# install dev tools
RUN apt-get update && \
    RUNLEVEL=1 apt-get install -y zeppelin

RUN  sed -i -e 's|yarn-client|spark://spark-master:7077|g' /etc/zeppelin/conf/zeppelin-env.sh &&\
     echo "export ZEPPELIN_JAVA_OPTS=\"-Dspark.executor.memory=1G -Dspark.cores.max=4\"" | tee -a /etc/zeppelin/conf/zeppelin-env.sh && \
    chmod -R 1777 /tmp 
#    rm /etc/zeppelin/conf.dist/interpreter.json

   
CMD ["/etc/bigtop/start_bigtop_services.sh", "zeppelin"]
EXPOSE 8088

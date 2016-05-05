# Creates Bigtop zeppelin docker image
#
# 

FROM bigtop-hadoop-node:ubuntu-15.04-ppc64le
MAINTAINER Amir Sanjar
USER root

# install dev tools
RUN apt-get update && \
    apt-get install -yq spark-core spark-python && \
    wget https://ci.bigtop.apache.org/job/Bigtop-trunk-packages/BUILD_ENVIRONMENTS=ubuntu-14.04,COMPONENTS=zeppelin,label=docker-slave/lastSuccessfulBuild/artifact/output/zeppelin/zeppelin_0.5.6-1_all.deb && \
    RUNLEVEL=1 dpkg -i zeppelin_0.5.6-1_all.deb && \
    rm zeppelin_0.5.6-1_all.deb

RUN  sed -i -e 's|yarn-client|spark://spark-master:7077|g' /etc/zeppelin/conf/zeppelin-env.sh &&\
     echo "export ZEPPELIN_JAVA_OPTS=\"-Dspark.executor.memory=1G -Dspark.cores.max=4\"" | tee -a /etc/zeppelin/conf/zeppelin-env.sh && \
    chmod -R 1777 /tmp
#    rm /etc/zeppelin/conf.dist/interpreter.json


CMD ["/etc/bigtop/start_bigtop_services.sh", "zeppelin"]
EXPOSE 8088 8080


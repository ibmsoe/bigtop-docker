# Creates Bigtop base docker image
#
# 

FROM bigtop-hadoop-node:ubuntu-15.04-x86_64
MAINTAINER Amir Sanjar
USER root

# install dev tools
RUN RUNLEVEL=1 apt-get install -y hive

ENV HIVE_HOME /usr/lib/hive
ENV HIVE_CONF_DIR /etc/hive/conf

   
CMD ["/etc/bigtop/start_bigtop_services.sh", "hive"]
EXPOSE 8080 7077 

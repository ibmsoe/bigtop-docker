# Creates Bigtop base docker image
#
# 

FROM bigtop-deploy-base:ubuntu-15.04-x86_64
MAINTAINER Amir Sanjar
USER root

ADD bigtop_list /etc/bigtop_list

RUN /etc/install_bigtop_stack.sh

CMD ["bash"]
#EXPOSE 50020 50090 50070 50010 50075 8031 8032 8033 8040 8042 49707 22 8088 8030

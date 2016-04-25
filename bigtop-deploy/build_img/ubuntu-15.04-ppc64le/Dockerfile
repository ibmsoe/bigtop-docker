# Creates Bigtop base docker image
#
# 

FROM bigtop-deploy-base:ubuntu-15.04-ppc64le
MAINTAINER Amir Sanjar
USER root
RUN apt-get update

ADD vagrantconfig.yaml /etc/vagrantconfig.yaml
ADD install_bigtop_stack.sh /etc/install_bigtop_stack.sh
RUN chown root:root /etc/install_bigtop_stack.sh
RUN chmod 700 /etc/install_bigtop_stack.sh

RUN /etc/install_bigtop_stack.sh /etc/vagrantconfig.yaml

CMD ["bash"]
#EXPOSE 50020 50090 50070 50010 50075 8031 8032 8033 8040 8042 49707 22 8088 8030

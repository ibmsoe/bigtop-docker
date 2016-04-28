#!/bin/bash

add_element(){
  name=$1
  value=$2
  xml_file=$3

  CONTENT="<property>\n<name>$name</name>\n<value>$value</value>\n</property>"
  C=$(echo $CONTENT | sed 's/\//\\\//g')
  sed -i -e "/<\/configuration>/ s/.*/${C}\n&/" $xml_file
}
## Add and init yarn.resourcemanager.address in yarn-site.xml
sed -i s/localhost/namenode/ /etc/hadoop/conf/core-site.xml
sed -i s/localhost/namenode/ /etc/hadoop/conf/mapred-site.xml
add_element "yarn.resourcemanager.hostname" "namenode" "/etc/hadoop/conf/yarn-site.xml"
add_element "yarn.resourcemanager.address" "namenode:8032" "/etc/hadoop/conf/yarn-site.xml"
add_element "yarn.resourcemanager.resource-tracker.address" "namenode:8031" "/etc/hadoop/conf/yarn-site.xml"
add_element "yarn.resourcemanager.scheduler.address" "namenode:8030" "/etc/hadoop/conf/yarn-site.xml"
add_element "dfs.namenode.datanode.registration.ip-hostname-check" "false" "/etc/hadoop/conf/hdfs-site.xml"


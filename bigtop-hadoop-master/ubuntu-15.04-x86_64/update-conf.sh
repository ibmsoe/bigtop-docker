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

add_element "yarn.resourcemanager.address" "rm_host:8032" "/etc/hadoop/conf/yarn-site.xml"
add_element "yarn.resourcemanager.resource-tracker.address" "rm_host:8031" "/etc/hadoop/conf/yarn-site.xml"
add_element "yarn.resourcemanager.resource-tracker.address" "rm_host:8030" "/etc/hadoop/conf/yarn-site.xml"


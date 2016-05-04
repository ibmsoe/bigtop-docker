#!/bin/bash
change_xml_element() {
  name=$1
  value=$2
  file=$3
  sed  -i "/<name>$name<\/name>/!b;n;c<value>$value</value>" $file
}

add_xml_element(){
  name=$1
  value=$2
  xml_file=$3

  CONTENT="<property>\n<name>$name</name>\n<value>$value</value>\n</property>"
  C=$(echo $CONTENT | sed 's/\//\\\//g')
  sed -i -e "/<\/configuration>/ s/.*/${C}\n&/" $xml_file
}


echo "Calling optimizer script.."

##### EXAMPLES:
#change_xml_element $1 $2 $3
#change_xml_element "dfs.namenode.name.dir" "sd1://name1" "/etc/hadoop/conf/hdfs-site.xml"
#change_xml_element "dfs.namenode.data.dir" "sd1://aada1,dada2" "/etc/hadoop/conf/hdfs-site.xml"

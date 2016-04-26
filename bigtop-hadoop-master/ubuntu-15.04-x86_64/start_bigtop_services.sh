#!/bin/bash

rm /tmp/*.pid

service ssh start

for var in "$@"
do
	case $var in
	"namenode")
          service hadoop-hdfs-namenode restart
	;;
	"datanode")
          service hadoop-hdfs-datanode restart
	;;
	"resourcemanager")
          service hadoop-yarn-resourcemanager restart
	;;
	"nodemanager")
          service hadoop-yarn-nodemanager restart
	;;
	"historyserver")
          service  hadoop-mapreduce-historyserver restart
	;;
	"timelineserver")
          service hadoop-yarn-timelineserver restart
	;;
        "spark-master")
          service spark-master restart
	;;
        "spark-worker")
          service spark-worker restart
	;;
        *)
        echo "unsupported service to start"
        ;;
        esac
done

if [[ $1 = "-d" || $2 = "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 = "-bash" || $2 = "-bash" ]]; then
  /bin/bash
fi

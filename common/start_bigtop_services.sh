#!/bin/bash

wait_for_hdfs() {
   >&2 echo "HDFS is unavailable"
  # while su hdfs -c "hdfs dfsadmin -safemode wait" | grep ON
   until nc -z namenode 8020
      do
       >&2 echo "..... waiting for HDFS"
       sleep 5s 
      done
   >&2 echo "HDFS is available"
}

service ssh start
### Must run docker --privileged mode
node_ip_hostname="`hostname -i`\t`hostname -f`"
echo -e  $node_ip_hostname >> /data/hosts
umount /etc/hosts
mv /etc/hosts /etc/hosts.bak
ln -s /data/hosts /etc/hosts
rm $HADOOP_CONF_DIR/slaves

## Do any optimization here
if [ -f /data/pre_start.sh ]; then
  ./data/pre_start.sh
fi

for var in "$@"
do
	case $var in
	"namenode")
          echo -e "127.0.0.1	localhost"> /data/hosts
          echo -e $node_ip_hostname>> /data/hosts
          service hadoop-hdfs-namenode restart
          ## wait for hdfs service 
          sleep 20
          wait_for_hdfs
          su hdfs -c "hdfs dfs -mkdir -p /user/root"
          su hdfs -c "hdfs dfs -chown root /user/root" 
          su hdfs -c "hdfs dfs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate" 
          su hdfs -c "hdfs dfs -chown -R mapred:mapred /tmp/hadoop-yarn/staging" 
          su hdfs -c "hdfs dfs -chmod -R 1777 /tmp" 
          su hdfs -c "hdfs dfs -mkdir -p /var/log/hadoop-yarn" 
          su hdfs -c "hdfs dfs -chown yarn:mapred /var/log/hadoop-yarn"
	;;
	"datanode")
          service hadoop-hdfs-datanode restart
	;;
	"resourcemanager")
          service hadoop-yarn-resourcemanager restart
          service hadoop-mapreduce-historyserver start
          service hadoop-yarn-timelineserver restart
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
          wait_for_hdfs
          service spark-master restart
          su hdfs -c "hadoop fs -mkdir -p /directory"
	  su hdfs -c "hadoop fs -chown -R spark:hadoop /directory"
          su hdfs -c "hdfs dfs -chmod -R 1777 /directory"
          su hdfs -c "hdfs dfs -mkdir -p  /var/log/spark/apps"
          su hdfs -c "hdfs dfs -chown -R root:hadoop /var/log/spark"
          
	;;
        "spark-worker")
          service spark-worker restart
	;;
        "zeppelin")
          wait_for_hdfs
          su hdfs -c "hdfs dfs -mkdir /user/zeppelin"
          su hdfs -c "hdfs dfs -chown -R zeppelin /user/zeppelin"
          service zeppelin restart
	;;
        "hive")
          wait_for_hdfs
          su hdfs -c "hdfs dfs -mkdir -p /user/hive/warehouse"
          su hdfs -c "hdfs dfs -chown -R root /user/hive"
          /usr/lib/hive/bin/hiveserver2  &
          #cat /etc/passwd | grep -i hive | sed -i 's/false/bash/' /etc/passwd
          #su hive
	;;
        "-d")
          while true; do sleep 1000; done
	;;
        "-bash")
        /bin/bash
        ;;
        *)
        echo "unsupported service to start"
        ;;
        esac
done



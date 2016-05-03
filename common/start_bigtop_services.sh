#!/bin/bash


service ssh start
### Must run docker --privileged mode
node_ip_hostname="`hostname -i`\t`hostname -f`"
echo -e  $node_ip_hostname >> /data/hosts
umount /etc/hosts
mv /etc/hosts /etc/hosts.bak
ln -s /data/hosts /etc/hosts

for var in "$@"
do
	case $var in
	"namenode")
          echo -e $node_ip_hostname> /data/hosts
          service hadoop-hdfs-namenode restart
          ## wait for namenode service 
          sleep 10
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
          su hdfs -c "hadoop fs -mkdir -p /directory"
	  su hdfs -c "hadoop fs -chown -R spark:hadoop /directory"
          su hdfs -c "hdfs dfs -chmod -R 1777 /directory"
          su hdfs -c "hdfs dfs -mkdir -p  /var/log/spark/apps"
          su hdfs -c "hdfs dfs -chown -R root:hadoop /var/log/spark"
          # pypsark requires localhost set
          node_ip_hostname="`hostname -i`\tlocalhost"
          echo -e  $node_ip_hostname >> /data/hosts
          
	;;
        "spark-worker")
          service spark-worker restart
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



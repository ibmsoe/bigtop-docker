# How to create Apache Hadoop/Spark cluster using Docker

## Only once - Build docker images for x86 and Power8

```
git clone https://github.com/ibmsoe/bigtop-docker.git
cd bigtop-docker
./build
```


# Start a Apache Hadoop 2.7.1 namenode 
### For x86
```
docker run --privileged -it --name namenode -h namenode -v `pwd`:/data bigtop-hadoop-master:ubuntu-15.04-x86_64 bash -l -c "/etc/start_bigtop_services.sh  namenode resourcemanager -bash"
```
### For ppc64le
```
docker run --privileged -it --name namenode -h namenode -v `pwd`:/data bigtop-hadoop-master:ubuntu-15.04-ppc64le bash -l -c "/etc/start_bigtop_services.sh  namenode resourcemanager -bash"
```
You should now be able to access the YARN Admin UI at
http://<namenode_ip>:8088


# Start Apache Hadoop/Spark worker container
In order to add data nodes to the Apache Hadoop cluster, use:
```
docker run --privileged -it --name slave1 -h slave1 --link namenode --dns 172.17.0.2 -v `pwd`:/data bigtop-hadoop-node86_64 bash -l -c "/etc/start_bigtop_services.sh datanode nodemanager -d"
```
### with Spark-worker 
```
docker run --privileged -it --name slave1 -h slave1 --link namenode --dns 172.17.0.2 -v `pwd`:/data bigtop-hadoop-node86_64 bash -l -c "/etc/start_bigtop_services.sh datanode nodemanager spark-wroker -d"
```

You should now be able to access the HDFS Admin UI at
http://<namenode_ip:50070

# Start Apache spark Master node
### For x86
```
docker run --privileged -it --name spark-master -h spark-master -v `pwd`:/data bigtop-spark-master:ubuntu-15.04-x86_64 bash -l -c "/etc/start_bigtop_services.sh  spark-master -bash"
```
### For ppc64le
```
docker run --privileged -it --name spark-master -h spark-master -v `pwd`:/data bigtop-spark-master:ubuntu-15.04-ppc64le bash -l -c "/etc/start_bigtop_services.sh  spark-master -bash"
```
## Verify Deployment
TBD

# Recommanded - Start Apache Yarn, namenode, and datanode nodes using docker-compose
```
docker-compose -f docker-compose.yml up -d
```
### For ppc64le
```
docker-compose -f docker-compose-ppc64le.yml up -d
```
# Recommanded - Start Apache Yarn, namenode, datanode, and spark master nodes using docker-compose
```
docker-compose -f bigtop-hadoop-spark.yml up -d
```
### For ppc64le
```
docker-compose -f bigtop-hadoop-spark-ppc64le.yml up -d
```

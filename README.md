#Apache Bigtop 1.1.0 cluster Docker image

# Build the images


# Start an Apache Hadoop 2.7.1 namenode container

```
docker run --privileged -it --name namenode -h namenode -v `pwd`:/data bigtop-hadoop-master:ubuntu-15.04-x86_64 bash -l -c "/etc/start_bigtop_services.sh  namenode resourcemanager -bash"
```
http://<namenode_ip>:8088


# Start an Apache Hadoop 2.7.1 slave container

In order to add data nodes to the Apache Hadoop cluster, use:
```
docker run --privileged -it --name slave1 -h slave1 --link namenode --dns 172.17.0.2 -v `pwd`:/data bigtop-hadoop-node86_64 bash -l -c "/etc/start_bigtop_services.sh datanode nodemanager -bash"

```

You should now be able to access the HDFS Admin UI at

http://<namenode_ip:50070


## Verify Deployment


# Start Apache Yarn namenode and datanode container by using docker-compose

```
sudo docker-compose -f docker-compose up -d
```

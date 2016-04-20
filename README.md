#Apache Bigtop 1.1.0 cluster Docker image

# Build the images


# Start an Apache Hadoop 2.7.1 namenode container

```
sudo docker run -it --name namenode -h namenode bigtop_node /etc/start_bigtop_services.sh -bash -namenode
```
http://<namenode_ip>:8088


# Start an Apache Hadoop 2.7.1 slave container

In order to add data nodes to the Apache Hadoop cluster, use:
```
sudo docker run -it --link namenode --dns=namenode bigtop_node /etc/start_bigtop_services.sh -bash -datanode {-spark}
```

You should now be able to access the HDFS Admin UI at

http://<namenode_ip:50070


## Verify Deployment


# Start Apache Yarn namenode and datanode container by using docker-compose

```
sudo docker-compose -f docker-compose up -d
```

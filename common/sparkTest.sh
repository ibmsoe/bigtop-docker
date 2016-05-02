#!/bin/bash

spark-submit --class org.apache.spark.examples.SparkPi $1 /usr/lib/spark/lib/spark-examples-1.5.1-hadoop2.7.1.jar 10

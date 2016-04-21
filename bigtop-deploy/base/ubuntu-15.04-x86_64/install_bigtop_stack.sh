#!/bin/bash

for var in "$@"
do
    apt-get install -yq "$var"
done

if [[ "$*" == "" ]]; then 
        echo "no bigtop list has been provided - reading from file"
	while read c
	do
	    apt-get install -yq "$c"
	done < /etc/bigtop_list
fi

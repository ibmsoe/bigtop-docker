#!/bin/bash
install_list=""
while read c
do
   if [[ $c == components* ]]; then      
       install_list=$(echo $c | sed "s/"components:"//g" | sed "s/\[//g" | sed "s/\]//g" | sed "s/,//g")
   fi
          
done < $1
echo $install_list
apt-get install -yq $install_list



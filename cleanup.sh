#!/bin/bash
names=(sacharya/apache sacharya/mysql sacharya/wordpress)
echo "Total containers: ${#names[*]}"

for item in ${names[*]}
do
    RUNNING=$(sudo docker ps | grep $item | awk '{print $1}')
    if [ ! -z $RUNNING ]; then
        echo "Cleaning container: $RUNNING"
        sudo docker stop $(sudo docker ps | grep $item | awk '{print $1}')
        sudo docker rm $(sudo docker ps -a | grep $item | awk '{print $1}')
        sudo docker rmi $(sudo docker images | grep $item | awk '{print $3}')
    fi 
done


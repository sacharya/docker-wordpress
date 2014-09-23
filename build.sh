#!/bin/bash

CONTAINER="sacharya/apache"
RUNNING=$(sudo docker ps | grep $CONTAINER | awk '{print $1}')
if [ -z $RUNNING ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  # create apache container
  sudo docker build -t $CONTAINER apache
  sudo docker run -p 8001:80 -d $CONTAINER
  # curl http://127.0.0.1:8001
fi

CONTAINER="sacharya/mysql"
RUNNING=$(sudo docker ps -a | grep $CONTAINER | awk '{print $1}')
if [ -z $RUNNING ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  # create mysql container
  sudo docker build -t $CONTAINER mysql
  sudo docker run -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password123 -d $CONTAINER
  # mysql -u root -h 127.0.0.1 -p 
fi

HOST_IP=`ifconfig eth0 | grep inet | head -n1 | cut -d":" -f2 | cut -d" " -f1`

CONTAINER="sacharya/wordpress"
RUNNING=$(sudo docker ps -a | grep $CONTAINER | awk '{print $1}')
if [ -z $RUNNING ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  # create wordpress container
  sudo docker build -t $CONTAINER wordpress
  sudo docker run -p 8002:80 -e DB_PASSWORD=password123 -e DB_1_PORT_3306_TCP_ADDR=$HOST_IP -e DB_1_PORT_3306_TCP_PORT=3306 -e DB_NAME=wordpressdb -d $CONTAINER
fi

WORDPRESS_DIP=`sudo docker inspect $(sudo docker ps | grep sacharya/wordpress | awk '{print $1}') | grep IPAddress | cut -d":" -f2 | cut -d'"' -f2`
echo "Wordpress Docker IP: $WORDPRESS_DIP"
sudo iptables -t nat -A  DOCKER -p tcp --dport 8002 -j DNAT --to-destination $WORDPRESS_DIP:80
echo "Go to http://$HOST_IP:8002 in your browser"

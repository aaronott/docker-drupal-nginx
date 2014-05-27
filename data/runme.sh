#!/bin/bash

TAG="docker-drupal-data"
LOCALDIR=`pwd`/data

CID=$(sudo docker ps | grep $TAG | awk '{print $1}')
# sudo docker ps -a | awk '{print $1}' | xargs -n1 -I {} sudo docker rm {}
if [ -n "${CID}" ] ; then
	echo ""
	echo "*** This docker is already running ***"
	echo "You can use 'sudo docker stop $CID' to end it"
	echo ""
else
  sudo docker build -t="${TAG}" . && \
    sudo docker run --name="data-container" $TAG true
    #sudo docker run -d -t -p $LOCALPORT:3306 docker-drupal-nginx --enable-insecure-key
  CID=$(sudo docker ps -a | grep $TAG | awk '{print $1}')
fi

if [ -n "${CID}" ] ; then
  sudo docker ps |grep docker-drupal-nginx

  CONTAINER_IP=$(sudo docker inspect $CID |grep IPAddress | awk '{print $2}' | xargs -n1 | sed 's/.$//')
	echo ""
  echo "Data Container is setup."
  #echo "SSH using 'ssh -i insecure_key root@$CONTAINER_IP'"
fi



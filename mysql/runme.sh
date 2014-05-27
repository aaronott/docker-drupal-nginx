#!/bin/bash

LOCALPORT=23306
TAG="docker-drupal-mysql"
LOCALDIR=`pwd`/data

CID=$(sudo docker ps | grep $TAG | grep $LOCALPORT | awk '{print $1}')
# sudo docker ps -a | awk '{print $1}' | xargs -n1 -I {} sudo docker rm {}
if [ -n "${CID}" ] ; then
	echo ""
	echo "*** This docker is already running on port $LOCALPORT ***"
	echo "You can use 'sudo docker stop $CID' to end it"
	echo ""
else
  if [ ! -f /usr/local/bin/docker ]; then  
	  sudo apt-get -y install docker
	  curl get.docker.io | sudo sh -x
  fi
  sudo docker build -t="${TAG}" . && \
    sudo docker run --volumes-from=[data-container] -d -t -p $LOCALPORT:3306 -v /data/mysql:$LOCALDIR $TAG /data/mysql
    #sudo docker run -d -t -p $LOCALPORT:3306 docker-drupal-nginx --enable-insecure-key
  CID=$(sudo docker ps | grep $TAG | grep $LOCALPORT | awk '{print $1}')
fi

if [ -n "${CID}" ] ; then
  sudo docker ps |grep docker-drupal-nginx

  CONTAINER_IP=$(sudo docker inspect $CID |grep IPAddress | awk '{print $2}' | xargs -n1 | sed 's/.$//')
	echo ""
  echo "Drupal is installed and running"
  echo "Use your browser to navigate to http://localhost:$LOCALPORT"
  echo "SSH using 'ssh -i insecure_key root@$CONTAINER_IP'"
fi



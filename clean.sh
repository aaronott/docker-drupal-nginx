#!/bin/bash
sudo docker ps -a
sudo docker ps -a | awk '{print $1}' | xargs -n1 -I {} sudo docker rm {}
sudo docker images
sudo docker images | awk '{print $3}' | xargs -n1 -I {} sudo docker rmi {}

#!/bin/bash -xv

set -e

# install docker
sudo apt-get update -y
sudo apt install docker.io -y
sudo docker image ls -a
#sudo docker run hello-world
#sudo docker image ls -a

# log into ecr
aws ecr get-login-password | \
    sudo docker login --username AWS --password-stdin ${awsAccountId}.dkr.ecr.${awsRegion}.amazonaws.com

# pull docker image from ecr
sudo docker pull ${awsAccountId}.dkr.ecr.${awsRegion}.amazonaws.com/unity/${dockerImageName}:${dockerImageTag}

# start dapa service
#    --network host \
sudo docker run \
    --name ${dockerImageName} \
    --rm \
    -e SDAP_SERVER_URL_PREFIX=${sdapServerUrlPrefix} \
    -p 8080:8080 \
     ${awsAccountId}.dkr.ecr.${awsRegion}.amazonaws.com/unity/${dockerImageName}:${dockerImageTag} > ${dockerImageName}.log 2>&1 &

#!/bin/bash

HERE=$(cd $(dirname $0) ; pwd)

# Wait for docker to start
 while ! docker ps ; do sleep 3 ; done

IMAGE=yarmand/docker-dev-env:general-latest
docker pull $IMAGE

cd $HERE/..
docker-compose down
docker-compose -f docker-compose.yaml -f mac/docker-compose.yaml up


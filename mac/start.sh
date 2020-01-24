#!/bin/bash

# Wait for docker to start
 while ! docker ps ; do sleep 3 ; done

IMAGE=docker.pkg.github.com/yarmand/docker-dev-env/general:latest
docker pull $IMAGE || echo 'cannot pull the image you may want to do: docker login docker.pkg.github.com'

cd ..
docker-compose down
docker-compose up


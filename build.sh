IMAGE=yarmand/docker-dev-env:latest

docker pull $IMAGE

docker build -t $IMAGE .

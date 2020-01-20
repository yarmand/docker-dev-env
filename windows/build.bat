set IMAGE=docker.pkg.github.com/yarmand/docker-dev-env/base:latest

docker pull %IMAGE% || echo 'cannot pull the image you may want to do: docker login docker.pkg.github.com'

docker build -t %IMAGE% ..

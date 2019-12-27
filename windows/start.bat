
REM wait for docker to start
:repeat
docker ps || sleep 3 && goto repeat

set IMAGE=docker.pkg.github.com/yarmand/docker-dev-env/general:latest
docker pull %IMAGE% || echo 'cannot pull the image you may want to do: docker login docker.pkg.github.com'

cd ..
docker-compose down
docker-compose up



REM wait for docker to start
:repeat
docker ps || sleep 3 && goto repeat

set IMAGE=yarmand/docker-dev-env:latest
docker pull %IMAGE% 
cd ..
docker-compose  down
docker-compose -f docker-compose.yaml -f windows/docker-compose.yaml up


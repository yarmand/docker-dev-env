
REM wai for docker to start
:repeat
docker ps || sleep 3 && goto repeat

docker volume create docker-dev-env_home
docker volume create docker-dev-env_opt
docker volume create docker-dev-env_src

set IMAGE=docker.pkg.github.com/yarmand/docker-dev-env/general:latest
docker pull %IMAGE% || echo 'cannot pull the image you may want to do: docker login docker.pkg.github.com'

docker rm -f samba
docker rm -f docker-dev-env

docker run --name samba ^
        --net=host ^
        -e USERID=0 ^
        -e GROUPIP=0 ^
        -v docker-dev-env_home:/home ^
        -v docker-dev-env_opt:/opt ^
        -v docker-dev-env_src:/src ^
        --rm ^
        -d ^
        dperson/samba ^
          -s "HOME;/home;yes;no" ^
          -s "OPT;/opt;yes;no" ^
          -s "SRC;/src;yes;no"

docker run --rm -it ^
        --name docker-dev-env ^
        -v docker-dev-env_home:/root ^
        -v docker-dev-env_src:/src ^
        -v docker-dev-env_opt:/opt ^
        -v %userprofile%/.ssh/id_rsa.pub:/home/id_rsa.pub ^
        -v /c:/mnt/c ^
        -v /var/run/docker.sock:/var/run/docker.sock ^
        -v /usr/local/bin/docker:/usr/local/bin/docker ^
        -p 9022:22 ^
        %IMAGE%

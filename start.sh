
docker volume create docker-dev-env_home
docker volume create docker-dev-env_opt
docker volume create docker-dev-env_src

docker build -t docker-dev-env .

docker run --rm -it \
        --name docker-dev-env \
        -v docker-dev-env_home:/root \
        -v docker-dev-env_src:/src \
        -v docker-dev-env_opt:/opt \
        -v /Volumes/Users:/mnt/users \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /usr/local/bin/docker:/usr/local/bin/docker \
        -p 9022:22 \
        docker-dev-env 

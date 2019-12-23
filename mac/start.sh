
docker volume create docker-dev-env_home
docker volume create docker-dev-env_opt
docker volume create docker-dev-env_src

docker run --name samba \
        --net=host \
        -e USERID=0 \
        -e GROUPIP=0 \
        -v docker-dev-env_home:/home \
        -v docker-dev-env_opt:/opt \
        -v docker-dev-env_src:/src \
        -v ~/.ssh/id_rsa.pub:/home/id_rsa.pub \
        --rm \
        -d \
        dperson/samba \
          -s "HOME;/home;yes;no" \
          -s "OPT;/opt;yes;no" \
          -s "SRC;/src;yes;no"

docker build -t docker-dev-env ..

docker run --rm -it \
        --name docker-dev-env \
        -v docker-dev-env_home:/root \
        -v docker-dev-env_src:/src \
        -v docker-dev-env_opt:/opt \
        -v /Users/$(whoami):/Users/$(whoami) \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /usr/local/bin/docker:/usr/local/bin/docker \
        -p 9022:22 \
        docker-dev-env

#!/bin/bash

DOCKER_IMAGE=yarmand/tmux-vim
HOME_PATH=/c/Users/yarma
docker rm ssh-container
docker rm -f tmux-vim
sed -i -e 's/\[localhost\]:9022.*//' ~/.ssh/known_hosts 
docker create -v /root/.ssh --name ssh-container $DOCKER_IMAGE /bin/true
docker run --volumes-from ssh-container $DOCKER_IMAGE ssh-keygen -q -f /root/.ssh/id_rsa -N ''
docker run --volumes-from ssh-container $DOCKER_IMAGE cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
docker run --volumes-from ssh-container -v $(pwd):/backup $DOCKER_IMAGE cp -R /root/.ssh/id_rsa /backup/id_for_container
docker run -d -p 9022:22 --volumes-from ssh-container -v $HOME_PATH:/home/developer --name=tmux-vim --hostname=tmux-vim $DOCKER_IMAGE
ssh -i id_for_container -p 9022 root@localhost -t source /home/init.sh

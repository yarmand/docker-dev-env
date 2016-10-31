#!/bin/bash

DOCKER_SHELL_IMAGE=yarmand/devenv-shell
CODE_DOCKER_IMAGE=yarmand/devenv-code

while [[ $# -gt 1 ]] ; do
  key="$1"

  case $key in
    -h|--help)
      usagea $0
      exit
      ;;
    -s|--shell-docker-image)
      DOCKER_SHELL_IMAGE="$2"
      shift 2 # past argument
      ;;
    -c|--code-docker-image)
      CODE_DOCKER_IMAGE="$2"
      shift 2 # past argument
      ;;
    *)
      # unknown option
      ;;
  esac
done

function usage()
{
  PRG=$1
  echo "$PRG [-s|--shell-done-image image] [-c|--code-docker-image image] commands"
  echo "   commands:"
  echo "      build  build images"
  echo "      new    start containers and connect to the shell"
}

function start_code_container()
{
  docker run -d --net=host -p 137-139:137-139 -p 445:445 -v $(pwd)/code-container:/config --name code $CODE_DOCKER_IMAGE
}

function init_shell_container()
{
  ### shell container
  HOME_PATH=/c/Users/yarma
  docker rm ssh-container
  docker rm -f tmux-vim
  sed -i -e 's/\[localhost\]:9022.*//' ~/.ssh/known_hosts
  docker create -v /root/.ssh --name ssh-container $DOCKER_SHELL_IMAGE /bin/true
  docker run --volumes-from ssh-container $DOCKER_SHELL_IMAGE ssh-keygen -q -f /root/.ssh/id_rsa -N ''
  docker run --volumes-from ssh-container $DOCKER_SHELL_IMAGE cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
  docker run --volumes-from ssh-container -v $(pwd):/backup $DOCKER_SHELL_IMAGE cp -R /root/.ssh/id_rsa /backup/id_for_container
}

function start_shell_container()
{
  docker run -d -p 9022:22 --volumes-from ssh-container -v $HOME_PATH:/home/developer --name=tmux-vim --hostname=tmux-vim $DOCKER_SHELL_IMAGE
}

function connect_shell()
{
  ssh -i id_for_container -p 9022 root@localhost -t source /home/init.sh
}

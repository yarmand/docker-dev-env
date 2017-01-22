FROM ubuntu:16.04

MAINTAINER Yann Armand <yann@harakys.com>

RUN apt update
RUN apt install -y \
        build-essential \
        ctags \
        git \
        openssh-server \
        sudo
RUN apt install -y \
        tig \
        zsh \
        tmux \
        exuberant-ctags \
        vim

RUN chsh -s /usr/bin/zsh

RUN apt install curl
RUN curl -L -o /usr/bin/docker-compose \
        https://github.com/docker/compose/releases/download/1.10.0/docker-compose-Linux-x86_64 && \
        chmod +x /usr/bin/docker-compose

COPY id_rsa.pub /home/id_rsa.pub_
COPY aliases /home/.aliases

COPY start.sh /home/start.sh
RUN chmod +x /home/start.sh

CMD ["/bin/bash", "-c", "/home/start.sh"]


FROM ubuntu:16.04

MAINTAINER Yann Armand <yann@harakys.com>

RUN apt-get update && apt install -y \
        build-essential \
        ctags \
        git \
        openssh-server \
        samba \
        sudo
RUN apt-get update && apt install -y \
        tig \
        zsh \
        tmux \
        exuberant-ctags \
        silversearcher-ag \
        iputils-ping \
        traceroute \
        dnsutils \
        net-tools \
        host \
        unzip \
        vim

RUN apt-get update && apt install -y \
        libyaml-0-2 \
        zlib1g \
        zlib1g-dev \
        libcurl3 \
        libcurl3-dev

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


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
        vim

RUN echo 'developer ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN adduser --shell /usr/bin/zsh \
            --disabled-password \
            --home /home/developer \
            developer
COPY id_rsa.pub /home/id_rsa.pub

COPY start.sh /home/start.sh
RUN chmod +x /home/start.sh

CMD ["/bin/bash", "-c", "/home/start.sh"]


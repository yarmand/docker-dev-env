FROM ubuntu:18.04

MAINTAINER Yann Armand <yann@harakys.com>

RUN apt-get update && apt install -y \
        build-essential \
        ctags \
        git
RUN apt-get update && apt install -y \
        openssh-server \
        openvpn
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
        vim \
        jq \
        sshuttle \
        man

# vim8 and neovim
RUN apt-get update && apt-get install -y \
      software-properties-common
RUN add-apt-repository ppa:jonathonf/vim
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update && apt-get install -y \
      vim \
      neovim

RUN apt-get update && apt install -y \
        libyaml-0-2 \
        zlib1g \
        zlib1g-dev \
        libcurl4 \
        libcurl4-openssl-dev \
        curl

RUN chsh -s /usr/bin/zsh

RUN curl -L -o /usr/bin/docker-compose \
        https://github.com/docker/compose/releases/download/1.23.2/docker-compose-Linux-x86_64 && \
        chmod +x /usr/bin/docker-compose

ENV PATH=${PATH}:/usr/local/go/bin

# ruby
RUN cd && wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz && \
    tar -xzvf chruby-0.3.9.tar.gz && \
    cd chruby-0.3.9/ &&\
    sudo make install &&\
    wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz &&\
    tar -xzvf ruby-install-0.6.1.tar.gz &&\
    cd ruby-install-0.6.1/ &&\
    sudo make install &&\
    cd && rm -rf chruby-0.3.9
    # rubies will install in /opt which is a persistent volume

# node 8
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - &&\
    sudo apt-get update && \
    sudo apt-get install -y nodejs

# golang
RUN cd && \
    set -eux; \
    GO_VERION=1.11.4 ; \
    REL_SHA=fb26c30e6a04ad937bbc657a1b5bba92f80096af1e8ee6da6430c045a8db3a5b ; \
    PACKAGE=go${GO_VERION}.linux-amd64.tar.gz ; \
    curl -L -O https://dl.google.com/go/${PACKAGE} ; \
    echo "${REL_SHA} ${PACKAGE}" | sha256sum -c - ; \
    tar -C /usr/local -xzf ${PACKAGE} ; \
    rm  -f ${PACKAGE}

# azure-cli
RUN apt-get install apt-transport-https lsb-release software-properties-common dirmngr -y &&\
    (AZ_REPO=$(lsb_release -cs) ; echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main") | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF && \
    apt-get update && \
    apt-get install azure-cli && \
    mv /opt/az /usr/local/az
    # move azure-cli /opt/az into /usl/local as my docker-compose use a persisted /opt


# local timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY id_rsa.pub /home/id_rsa.pub
COPY aliases /home/.aliases

COPY start.sh /home/start.sh
RUN chmod +x /home/start.sh

CMD ["/bin/bash", "-c", "/home/start.sh"]


FROM ubuntu:16.04

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
        libcurl3 \
        libcurl3-dev \
        curl

RUN chsh -s /usr/bin/zsh

RUN curl -L -o /usr/bin/docker-compose \
        https://github.com/docker/compose/releases/download/1.10.0/docker-compose-Linux-x86_64 && \
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

RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.27.tar.gz && \
    tar -xzf freetds-1.00.27.tar.gz && \
    cd freetds-1.00.27 &&\
    ./configure --prefix=/usr/local --with-tdsver=7.3 &&\
    make &&\
    make install

# node 8
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - &&\
    sudo apt-get update && \
    sudo apt-get install -y nodejs

# azure-cli
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893 && \
    apt-get install apt-transport-https && \
    apt-get update && sudo apt-get install azure-cli && \
    mv /opt/az /usr/local/az
    # move azure-cli /opt/az into /usl/local as my docker-compose use a persisted /opt
# golang
RUN cd && curl -L -O https://storage.googleapis.com/golang/go1.9.2.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz &&\
    rm  -f go1.9.2.linux-amd64.tar.gz


# local timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY id_rsa.pub /home/id_rsa.pub
COPY aliases /home/.aliases

COPY start.sh /home/start.sh
RUN chmod +x /home/start.sh

CMD ["/bin/bash", "-c", "/home/start.sh"]


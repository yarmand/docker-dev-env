##########
## BASE ##
##########
FROM ubuntu:18.04 as base

RUN apt-get update && apt-get install -y \
      software-properties-common
RUN add-apt-repository ppa:rmescandon/yq 
RUN add-apt-repository ppa:jonathonf/vim

RUN apt-get update && apt install -y \
        build-essential \
        ctags \
        git \
        htop \
        openssh-server \
        gnupg-agent \
        openvpn \
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
        jq \
        yq \
        sshuttle \
        vim \
        man \
        libyaml-0-2 \
        zlib1g \
        zlib1g-dev \
        libcurl4 \
        libcurl4-openssl-dev \
        curl

#zsh
RUN chsh -s /usr/bin/zsh
RUN echo '. /etc/profile' >>/etc/zsh/zprofile

# docker tools
## docker-compose
RUN curl -L -o /usr/bin/docker-compose \
        https://github.com/docker/compose/releases/download/1.25.0/docker-compose-Linux-x86_64 && \
        chmod +x /usr/bin/docker-compose
## kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
      chmod +x ./kubectl && \
      mv ./kubectl /usr/local/bin/kubectl

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
    # We move azure-cli /opt/az into /usl/local as /opt will be a persistent volume

# local timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD dotfiles /home/shared/dotfiles
RUN chmod +x /home/shared/dotfiles/setup.sh

COPY init.sh /home/init.sh
RUN chmod +x /home/init.sh

ENTRYPOINT ["/bin/bash", "-c", "/home/init.sh"]
CMD ["/bin/bash", "-c", "while true ; do sleep 10000 ; done"]

############
## CHRUBY ##
############
# each ruby you want ot use will have to be build using ruby-install and will persist in /opt 
FROM docker.pkg.github.com/yarmand/docker-dev-env/base:latest as ruby
RUN cd && wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz && \
    tar -xzvf chruby-0.3.9.tar.gz && \
    rm -f chruby-0.3.9.tar.gz.* && \
    cd chruby-0.3.9/ &&\
    sudo make install &&\
    wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz &&\
    tar -xzvf ruby-install-0.6.1.tar.gz &&\
    cd ruby-install-0.6.1/ &&\
    sudo make install &&\
    cd && rm -rf chruby-0.3.9
    # rubies will install in /opt which is a persistent volume
COPY profile.d/ruby.sh /etc/profile.d/ruby.sh

############
## NODEJS ##
############
FROM docker.pkg.github.com/yarmand/docker-dev-env/base:latest as nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&\
    sudo apt-get update && apt-get install -y nodejs

########
## GO ##
########
FROM docker.pkg.github.com/yarmand/docker-dev-env/base:latest as go
ENV PATH=${PATH}:/usr/local/go/bin
RUN cd && \
    set -eux; \
    GO_VERION=1.13.5 ; \
    REL_SHA=512103d7ad296467814a6e3f635631bd35574cab3369a97a323c9a585ccaa569 \
    PACKAGE=go${GO_VERION}.linux-amd64.tar.gz ; \
    curl -L -O https://dl.google.com/go/${PACKAGE} ; \
    echo "${REL_SHA} ${PACKAGE}" | sha256sum -c - ; \
    tar -C /usr/local -xzf ${PACKAGE} ; \
    rm  -f ${PACKAGE}
ENV GO111MODULE=on

##########
## JAVA ##
##########
## openJDK 8
FROM docker.pkg.github.com/yarmand/docker-dev-env/base:latest as java
RUN apt-get update && sudo apt-get install -y openjdk-8-jdk
## maven
# Install Maven
ENV MVN_VERSION=3.5.4
RUN  cd /usr/local &&\
      curl -O http://mirrors.ocf.berkeley.edu/apache/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz && \
      tar zxf apache-maven-${MVN_VERSION}-bin.tar.gz
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV JDK_18=/usr/lib/jvm/java-8-openjdk-amd64
ENV maven=/usr/local/apache-maven-${MVN_VERSION}
ENV M2_HOME=/usr/local/apache-maven-${MVN_VERSION}
ENV MAVEN_HOME=/usr/local/apache-maven-${MVN_VERSION}

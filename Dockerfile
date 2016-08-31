FROM jare/alpine:latest

MAINTAINER Yann Armand <yann@harakys.com>

RUN apk add --update --virtual build-deps python python-dev ctags build-base    \
      make libxpm-dev libx11-dev libxt-dev ncurses-dev git                   && \
    cd /tmp                                                                  && \
    git clone https://github.com/vim/vim                                     && \
    cd /tmp/vim                                                              && \
    ./configure --with-features=big \
                #needed for editing text in languages which have many characters
                --enable-multibyte \
                #python interop needed for some of my plugins
                --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/config \
                --disable-gui \                 --disable-netbeans \
                --prefix /usr                                                && \
    make VIMRUNTIMEDIR=/usr/share/vim/vim74                                  && \
    make install                                                             && \
    apk del build-deps                                                       && \
    apk add libsm libice libxt libx11 ncurses                                && \
    #cleanup
    rm -rf /var/cache/* /var/log/* /var/tmp/*                                && \
    mkdir /var/cache/apk                                                     && \
    cd /usr/share/vim/vim74/                                                 && \
    sh /util/ocd-clean /

RUN apk --update --upgrade add tmux zsh openssh
    #&& /usr/sbin/rc-update add sshd

#set zsh as default shell
ENV SHELL=/bin/zsh

RUN mkdir -p /src

WORKDIR /src

# cleanup and settings
RUN rm -rf /var/cache/apk/* \
    && find / -type f -iname \*.apk-new -delete \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/etc/init.d/sshd", "start"]

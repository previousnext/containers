FROM       previousnext/php:5.6-base
MAINTAINER nick_schuch

ENV ENV_TYPE     DOCKER
ENV NVM_DIR      /usr/local/nvm
ENV NODE_VERSION 8.6.0
ENV NODE_PATH    $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH         $NVM_DIR/versions/node/v$NODE_VERSION/bin:/root/.yarn/bin:$PATH

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash && \
    source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN apt-get update && \
    apt-get install -y git \
                       bash-completion \
                       unzip \
                       libxml2-dev \
                       build-essential \
                       python \
                       ruby2.1 \
                       ruby2.1-dev && \
    gem2.1 install bundler && \
    apt-get clean

RUN echo '[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
              . /usr/share/bash-completion/bash_completion' >> ~/.bashrc

# https://github.com/docker-library/php/issues/77#issuecomment-88936146
RUN pecl install -o -f xdebug && \
    rm -rf /tmp/pear
ADD xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
ADD scripts/xdebug-set.sh /usr/local/bin/xdebug-set.sh
RUN /usr/local/bin/xdebug-set.sh /usr/local/etc/php/conf.d/xdebug.ini

# Skipper CLI toolkit.
RUN wget http://bins.skpr.io/linux-amd64-latest.tar.gz && \
      tar -zxf linux-amd64-latest.tar.gz -C /usr/local/bin/

# Temporary environment builder.
RUN curl -L https://s3.amazonaws.com/pnx-bins/m8s-cli-0.2.1_linux_amd64 -o /usr/local/bin/m8s && \
      chmod a+x /usr/local/bin/m8s

# Github deploy status
RUN curl -L https://s3.amazonaws.com/pnx-bins/deploy-status_linux_amd64 -o /usr/local/bin/deploy-status && \
      chmod a+x /usr/local/bin/deploy-status

# Skipper v2 CLI toolkit.
RUN curl -L https://s3-ap-southeast-2.amazonaws.com/bins.skpr.io/2.0.0/skpr-linux -o /usr/local/bin/skpr2 && \
      chmod +rx /usr/local/bin/skpr2

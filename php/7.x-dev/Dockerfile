FROM       previousnext/php:7.1
MAINTAINER nick_schuch

ENV NVM_DIR      /usr/local/nvm
ENV NODE_VERSION 5.11.1
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
                       unzip \
                       libxml2-dev \
                       build-essential \
                       python \
                       ruby2.1 \
                       ruby2.1-dev && \
    gem2.1 install bundler && \
    apt-get clean

# https://github.com/docker-library/php/issues/77#issuecomment-88936146
RUN pecl install -o -f xdebug && \
    rm -rf /tmp/pear
ADD xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Skipper CLI toolkit.
RUN wget http://bins.skpr.io/linux-amd64-latest.tar.gz && \
      tar -zxf linux-amd64-latest.tar.gz -C /usr/local/bin/

ADD start.sh /usr/local/bin/start-dev
RUN chmod a+x /usr/local/bin/start-dev

CMD ["/usr/local/bin/start-dev"]

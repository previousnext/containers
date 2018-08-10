ARG FROM=previousnext/php-apache:latest

FROM ${FROM}

ENV PATH "$PATH:/data/node_modules/.bin"

RUN apk add -u g++ \
               git \
               libffi-dev \
               nodejs-current \
               nodejs-current-npm \
               patch \
               php7-xdebug \
               python \
               openssh-client \
               ruby \
               ruby-bundler \
               ruby-dev \
               wget \
               yarn && \
    rm -rf /var/cache/apk/*

COPY dev.ini /etc/php7/conf.d/dev.ini
COPY xdebug.ini /etc/php7/conf.d/xdebug.ini

# Skipper
RUN wget http://bins.skpr.io/linux-amd64-latest.tar.gz && \
    tar -zxf linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
    rm -rf linux-amd64-latest.tar.gz

# M8s
RUN curl -L https://github.com/previousnext/m8s/releases/download/v0.7.1/m8s_linux_amd64 -o /usr/local/bin/m8s && \
    chmod a+x /usr/local/bin/m8s

# Github deploy status
RUN curl -L https://github.com/previousnext/go-deploy-status/releases/download/1.0.0-alpha3/deploy-status_linux_amd64 -o /usr/local/bin/deploy-status && \
    chmod a+x /usr/local/bin/deploy-status

# Hub
RUN curl -L http://bins.skpr.io/hub-latest -o /usr/local/bin/hub && \
      chmod +rx /usr/local/bin/hub

# Notify - https://github.com/previousnext/notify
RUN curl -L https://github.com/previousnext/notify/releases/download/2.1.0/notify_linux_amd64 -o /usr/local/bin/notify && \
    chmod +rx /usr/local/bin/notify

# MicroCron - https://github.com/previousnext/microcron
RUN curl -L https://github.com/previousnext/microcron/releases/download/v0.0.1/microcron_linux_amd64 -o /usr/local/bin/microcron && \
    chmod +rx /usr/local/bin/microcron

ARG FROM=previousnext/php-apache:latest

FROM ${FROM}

ARG ALPINE_VERSION=3.8
ARG PHP_VERSION=7.3

ENV PATH "$PATH:/data/node_modules/.bin"

ENV XDEBUG_ENABLED=yes

RUN apk add -u g++ \
               git \
               libffi-dev \
               jq \
               nodejs \
               npm \
               patch \
               php${PHP_VERSION}-xdebug \
               python \
               openssh-client \
               ruby \
               ruby-bundler \
               ruby-dev \
               wget \
               yarn && \
    rm -rf /var/cache/apk/*

# https://blog.blackfire.io/alpine-linux-support.html
RUN PHP_VERISON=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") && \
    curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/alpine/amd64/$PHP_VERISON && \
    mkdir -p /tmp/blackfire && \
    tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire && \
    mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so && \
    rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz

# Example config files for docker-entrypoint.d toggles.
RUN mkdir /etc/php7/conf.d/example
COPY blackfire.ini /etc/php7/conf.d/example/blackfire.ini
COPY xdebug.ini /etc/php7/conf.d/example/xdebug.ini

COPY dev.ini /etc/php7/conf.d/dev.ini

# Skipper
RUN wget http://bins.skpr.io/linux-amd64-latest.tar.gz && \
    tar -zxf linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
    rm -rf linux-amd64-latest.tar.gz

# M8s
RUN curl -L https://github.com/previousnext/m8s/releases/download/v0.8.0/m8s_linux_amd64 -o /usr/local/bin/m8s && \
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

# Semantic - https://github.com/nickschuch/semantic
RUN curl -L https://github.com/nickschuch/semantic/releases/download/0.0.2/semantic-linux-amd64 -o /usr/local/bin/semantic && \
    chmod +rx /usr/local/bin/semantic

COPY /docker-entrypoint.d/* /docker-entrypoint.d/

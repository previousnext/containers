ARG BASE_IMAGE=previousnext/php-apache:latest

FROM ${BASE_IMAGE}

ENV PATH "$PATH:/data/node_modules/.bin"

RUN apk add -u php7-xdebug \
               nodejs \
               yarn \
               python \
               g++ && \
    rm -rf /var/cache/apk/*

ADD dev.ini /usr/local/etc/php/conf.d/dev.ini
ADD xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Skipper
RUN wget http://bins.skpr.io/linux-amd64-latest.tar.gz && \
    tar -zxf linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
    rm -rf linux-amd64-latest.tar.gz

# M8s
RUN curl -L https://github.com/previousnext/m8s/releases/download/v0.7.0/m8s_linux_amd64 -o /usr/local/bin/m8s && \
    chmod a+x /usr/local/bin/m8s

# Github deploy status
RUN curl -L https://github.com/previousnext/go-deploy-status/releases/download/1.0.0-alpha2/deploy-status_linux_amd64-1.0.0-alpha2 -o /usr/local/bin/deploy-status && \
    chmod a+x /usr/local/bin/deploy-status

# Hub
RUN cd /tmp && curl -L -O https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz && \
    tar -zxf hub-linux-amd64-2.2.9.tgz && \
    mv hub-linux-amd64-2.2.9/bin/hub /usr/local/bin/ && \
    chmod +x /usr/local/bin/hub && \
    rm -rf /tmp/hub-linux-amd64-2.2.9

# Notify - https://github.com/previousnext/notify
RUN curl -L https://github.com/previousnext/notify/releases/download/2.1.0/notify_linux_amd64 -o /usr/local/bin/notify && \
    chmod +rx /usr/local/bin/notify

# MicroCron - https://github.com/previousnext/microcron
RUN curl -L https://github.com/previousnext/microcron/releases/download/v0.0.1/microcron_linux_amd64 -o /usr/local/bin/microcron && \
    chmod +rx /usr/local/bin/microcron
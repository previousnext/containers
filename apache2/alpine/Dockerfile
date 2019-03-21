ARG ALPINE_VERSION=3.9

FROM alpine:${ALPINE_VERSION}

# hadolint ignore=DL3018
RUN apk add --update --no-cache \
  apache2 \
  apache2-utils \
  bash \
  bash-completion \
  curl \
  make \
  rsync \
  unzip \
  vim

# Tuner - https://github.com/previousnext/tuner
RUN curl -sL https://github.com/previousnext/tuner/releases/download/1.0.0/tuner-linux-amd64 -o /usr/local/bin/tuner && \
    chmod +rx /usr/local/bin/tuner

# Logging
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

COPY .bashrc /root/.bashrc
COPY httpd.conf /etc/apache2/httpd.conf
COPY status.conf /etc/apache2/conf.d/status.conf
COPY security.conf /etc/apache2/conf.d/security.conf

# These volumes allow us to run our containers in "readonly" mode.
VOLUME /run/apache2
VOLUME /run/lock/apache2
VOLUME /tmp
VOLUME /var/log/newrelic
VOLUME /var/run/tuner/apache2

WORKDIR /data

# https://www.camptocamp.com/en/actualite/flexible-docker-entrypoints-scripts/
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
COPY /docker-entrypoint.d/* /docker-entrypoint.d/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
# @todo, Change to use "httpd -D FOREGROUND" once entrypoint.sh can be retired.
CMD ["/entrypoint.sh"]

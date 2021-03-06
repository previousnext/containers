ARG ALPINE_VERSION=3.10

FROM alpine:${ALPINE_VERSION}
ARG ALPINE_VERSION=3.10
ARG PHP_VERSION=7.3

ENV PATH "$PATH:/data/bin"

ENV PHP_INI_SCAN_DIR=/etc/php/${PHP_VERSION}/conf.d:/var/run/tuner/php

RUN apk add --no-cache curl ca-certificates && \
    curl -sSL https://packages.skpr.io/php-alpine/skpr.rsa.pub -o /etc/apk/keys/skpr.rsa.pub && \
    echo "https://packages.skpr.io/php-alpine/${ALPINE_VERSION}/php${PHP_VERSION}" >> /etc/apk/repositories

RUN apk --update --no-cache add \
            apache2 \
            apache2-utils \
            bash \
            bash-completion \
            jpegoptim \
            libsodium \
            make \
            mysql-client \
            optipng \
            php${PHP_VERSION} \
            php${PHP_VERSION}-apache2 \
            php${PHP_VERSION}-apcu \
            php${PHP_VERSION}-bcmath \
            php${PHP_VERSION}-ctype \
            php${PHP_VERSION}-curl \
            php${PHP_VERSION}-dom \
            php${PHP_VERSION}-fileinfo \
            php${PHP_VERSION}-ftp \
            php${PHP_VERSION}-gd \
            php${PHP_VERSION}-iconv \
            php${PHP_VERSION}-json \
            php${PHP_VERSION}-mbstring \
            php${PHP_VERSION}-memcached \
            php${PHP_VERSION}-opcache \
            php${PHP_VERSION}-openssl \
            php${PHP_VERSION}-pcntl \
            php${PHP_VERSION}-pdo \
            php${PHP_VERSION}-pdo_mysql \
            php${PHP_VERSION}-pdo_sqlite \
            php${PHP_VERSION}-phar \
            php${PHP_VERSION}-posix \
            php${PHP_VERSION}-session \
            php${PHP_VERSION}-simplexml \
            php${PHP_VERSION}-soap \
            php${PHP_VERSION}-sockets \
            php${PHP_VERSION}-sodium \
            php${PHP_VERSION}-sqlite3 \
            php${PHP_VERSION}-tokenizer \
            php${PHP_VERSION}-xml \
            php${PHP_VERSION}-xmlreader \
            php${PHP_VERSION}-xmlwriter \
            php${PHP_VERSION}-zip \
            pngquant \
            rsync \
            tesseract-ocr \
            tesseract-ocr-dev \
            poppler-utils \
            unzip \
            vim

# This provides a compatibility layer for developer who are adding
# custom php.ini files to their projects.
# Bumping PHP versions should not result in changes to their Dockerfiles.
RUN ln -s /etc/php/${PHP_VERSION} /etc/php7

COPY .bashrc /root/.bashrc
COPY httpd.conf /etc/apache2/httpd.conf
COPY status.conf /etc/apache2/conf.d/status.conf
COPY security.conf /etc/apache2/conf.d/security.conf
COPY drushrc.php /etc/drush/drushrc.php
COPY drush.yml /etc/drush/drush.yml
COPY apcu.ini /etc/php7/conf.d/01_apcu.ini
COPY overrides.ini /etc/php7/conf.d/50_overrides.ini
COPY skpr.php /etc/skpr/skpr.php

# Liveness
COPY liveness /var/www/liveness

# New Relic - https://docs.newrelic.com/docs/release-notes/agent-release-notes/php-release-notes
# hadolint ignore=DL3003,DL4006,SC2115
RUN export NR_INSTALL_SILENT=true && \
    export NR_INSTALL_USE_CP_NOT_LN=true && \
    export NR_VERSION=9.11.0.267 && \
    export NR_FILENAME=newrelic-php5-${NR_VERSION}-linux-musl && \
    curl -sSL https://download.newrelic.com/php_agent/archive/${NR_VERSION}/${NR_FILENAME}.tar.gz | gzip -dc | tar xf - && \
    cd ${NR_FILENAME} && ./newrelic-install install && \
    rm -fR /${NR_FILENAME}
COPY newrelic.ini /etc/php7/conf.d/newrelic.ini

# Logging
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# Add Amazon RDS TLS public certificate.
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem  /etc/ssl/certs/rds-combined-ca-bundle.pem
RUN chmod 755 /etc/ssl/certs/rds-combined-ca-bundle.pem

# Composer 1 & 2
# hadolint ignore=DL4006
RUN curl -sS https://getcomposer.org/composer-1.phar -o /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/composer-2.phar -o /usr/local/bin/composer2 && \
    chmod +x /usr/local/bin/composer2

# Tuner - https://github.com/previousnext/tuner
RUN curl -sSL https://github.com/previousnext/tuner/releases/download/1.1.0/tuner_linux_amd64 -o /usr/local/bin/tuner && \
    chmod +rx /usr/local/bin/tuner

RUN curl -sSL https://s3.amazonaws.com/pnx-bins/docconv-v1.0.0-129-geedabc4-alpine${ALPINE_VERSION} -o /usr/local/bin/docconv && \
    chmod +rx /usr/local/bin/docconv

# Ruby errors if a sticky bit isn't set on /tmp.
# @expire 2019-06-30
RUN chmod +t /tmp

# These volumes allow us to run our containers in "readonly" mode.
VOLUME /run/apache2
VOLUME /run/lock/apache2
VOLUME /tmp
VOLUME /var/log/newrelic
VOLUME /var/run/tuner/apache2
VOLUME /var/run/tuner/php

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

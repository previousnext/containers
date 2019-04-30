ARG ALPINE_VERSION=3.9

FROM alpine:${ALPINE_VERSION}
ARG ALPINE_VERSION=3.9
ARG PHP_VERSION=7.3

ENV PATH "$PATH:/data/bin"

ENV PHP_INI_SCAN_DIR=/etc/php/${PHP_VERSION}/conf.d:/var/run/tuner/php

RUN apk upgrade

RUN apk add --no-cache curl ca-certificates && \
    curl -L https://packages.skpr.io/php-alpine/skpr.rsa.pub -o /etc/apk/keys/skpr.rsa.pub && \
    echo "https://packages.skpr.io/php-alpine/${ALPINE_VERSION}/php${PHP_VERSION}" >> /etc/apk/repositories

RUN apk --update --no-cache add \
            apache2 \
            apache2-utils \
            bash \
            bash-completion \
            jpegoptim \
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
            php${PHP_VERSION}-sqlite3 \
            php${PHP_VERSION}-tokenizer \
            php${PHP_VERSION}-xml \
            php${PHP_VERSION}-xmlreader \
            php${PHP_VERSION}-xmlwriter \
            php${PHP_VERSION}-zip \
            pngquant \
            rsync \
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
COPY apcu.ini /etc/php7/conf.d/apcu.ini
COPY skpr.php /etc/skpr/skpr.php

# Liveness
COPY liveness /var/www/liveness

# New Relic
# hadolint ignore=DL3003,DL4006,SC2115
RUN export NR_INSTALL_SILENT=true && \
    export NR_INSTALL_USE_CP_NOT_LN=true && \
    export NR_VERSION=8.5.0.235 && \
    export NR_FILENAME=newrelic-php5-${NR_VERSION}-linux-musl && \
    curl -sS https://download.newrelic.com/php_agent/archive/${NR_VERSION}/${NR_FILENAME}.tar.gz | gzip -dc | tar xf - && \
    cd ${NR_FILENAME} && ./newrelic-install install && \
    rm -fR /${NR_FILENAME}
COPY newrelic.ini /etc/php7/conf.d/newrelic.ini

# Logging
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# Add Amazon RDS TLS public certificate.
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem  /etc/ssl/certs/rds-combined-ca-bundle.pem
RUN chmod 755 /etc/ssl/certs/rds-combined-ca-bundle.pem

# Composer
# hadolint ignore=DL4006
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

# Tuner - https://github.com/previousnext/tuner
RUN curl -L https://github.com/previousnext/tuner/releases/download/1.0.0/tuner-linux-amd64 -o /usr/local/bin/tuner && \
    chmod +rx /usr/local/bin/tuner

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

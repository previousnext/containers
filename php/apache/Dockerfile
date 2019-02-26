ARG ALPINE_VERSION=3.9

FROM alpine:${ALPINE_VERSION}
ARG ALPINE_VERSION=3.8
ARG PHP_VERSION=7.3

RUN apk add --no-cache curl ca-certificates && \
    curl https://repos.php.earth/alpine/phpearth.rsa.pub -o /etc/apk/keys/phpearth.rsa.pub && \
    echo "@phpearth https://repos.php.earth/alpine/v${ALPINE_VERSION}" >> /etc/apk/repositories

ENV PATH "$PATH:/data/bin"

ENV PHP_INI_SCAN_DIR=/etc/php/${PHP_VERSION}/conf.d:/var/run/tuner/php

RUN apk --update --no-cache add \
            apache2 \
            apache2-utils \
            bash \
            bash-completion \
            jpegoptim \
            make \
            mysql-client \
            optipng \
            php${PHP_VERSION}@phpearth \
            php${PHP_VERSION}-apache2@phpearth \
            php${PHP_VERSION}-apcu@phpearth \
            php${PHP_VERSION}-bcmath@phpearth \
            php${PHP_VERSION}-ctype@phpearth \
            php${PHP_VERSION}-curl@phpearth \
            php${PHP_VERSION}-dom@phpearth \
            php${PHP_VERSION}-ftp@phpearth \
            php${PHP_VERSION}-gd@phpearth \
            php${PHP_VERSION}-iconv@phpearth \
            php${PHP_VERSION}-json@phpearth \
            php${PHP_VERSION}-mbstring@phpearth \
            php${PHP_VERSION}-memcached@phpearth \
            php${PHP_VERSION}-opcache@phpearth \
            php${PHP_VERSION}-openssl@phpearth \
            php${PHP_VERSION}-pcntl@phpearth \
            php${PHP_VERSION}-pdo@phpearth \
            php${PHP_VERSION}-pdo_mysql@phpearth \
            php${PHP_VERSION}-pdo_sqlite@phpearth \
            php${PHP_VERSION}-phar@phpearth \
            php${PHP_VERSION}-posix@phpearth \
            php${PHP_VERSION}-session@phpearth \
            php${PHP_VERSION}-simplexml@phpearth \
            php${PHP_VERSION}-soap@phpearth \
            php${PHP_VERSION}-sqlite3@phpearth \
            php${PHP_VERSION}-tokenizer@phpearth \
            php${PHP_VERSION}-xml@phpearth \
            php${PHP_VERSION}-xmlreader@phpearth \
            php${PHP_VERSION}-xmlwriter@phpearth \
            php${PHP_VERSION}-zip@phpearth \
            pngquant \
            rsync \
            unzip \
            vim

COPY .bashrc /root/.bashrc
COPY httpd.conf /etc/apache2/httpd.conf
COPY status.conf /etc/apache2/conf.d/status.conf
COPY security.conf /etc/apache2/conf.d/security.conf
COPY drushrc.php /etc/drush/drushrc.php
COPY drush.yml /etc/drush/drush.yml
COPY apcu.ini /etc/php/${PHP_VERSION}/conf.d/apcu.ini

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
COPY newrelic.ini /etc/php/${PHP_VERSION}/conf.d/newrelic.ini

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

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

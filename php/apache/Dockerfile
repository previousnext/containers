ARG ALPINE_VERSION=3.9

FROM alpine:${ALPINE_VERSION}
ARG ALPINE_VERSION=3.9
ARG PHP_VERSION=7.3

# trust this project public key to trust the packages.
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

# make sure you can use HTTPS
RUN apk --update add ca-certificates

# add the repository, make sure you replace the correct versions if you want.
RUN echo "@cast https://php.codecasts.rocks/v${ALPINE_VERSION}/php-${PHP_VERSION}" >> /etc/apk/repositories

ENV PATH "$PATH:/data/bin"

ENV PHP_INI_SCAN_DIR=/etc/php7/conf.d:/var/run/tuner/php

RUN apk --update --no-cache add \
            apache2 \
            apache2-utils \
            bash \
            bash-completion \
            curl \
            jpegoptim \
            make \
            mysql-client \
            optipng \
            php@cast \
            php-apache2@cast \
            php-apcu@cast \
            php-bcmath@cast \
            php-ctype@cast \
            php-curl@cast \
            php-dom@cast \
            php-ftp@cast \
            php-gd@cast \
            php-iconv@cast \
            php-json@cast \
            php-mbstring@cast \
            php-memcached@cast \
            php-opcache@cast \
            php-openssl@cast \
            php-pcntl@cast \
            php-pdo@cast \
            php-pdo_mysql@cast \
            php-pdo_sqlite@cast \
            php-phar@cast \
            php-posix@cast \
            php-session@cast \
            php-simplexml@cast \
            php-soap@cast \
            php-sqlite3@cast \
            php-tokenizer@cast \
            php-xml@cast \
            php-xmlreader@cast \
            php-xmlwriter@cast \
            php-zip@cast \
            pngquant \
            rsync \
            unzip \
            vim

RUN ln -sv /usr/bin/php7 /usr/bin/php

COPY .bashrc /root/.bashrc
COPY httpd.conf /etc/apache2/httpd.conf
COPY status.conf /etc/apache2/conf.d/status.conf
COPY security.conf /etc/apache2/conf.d/security.conf
COPY drushrc.php /etc/drush/drushrc.php
COPY drush.yml /etc/drush/drush.yml
COPY apcu.ini /etc/php7/conf.d/apcu.ini

# Liveness
COPY liveness /var/www/liveness

# New Relic
# hadolint ignore=DL3003,DL4006
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

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

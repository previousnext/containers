ARG ALPINE_VERSION=3.7

FROM alpine:${ALPINE_VERSION}

ENV PATH "$PATH:/data/bin"

ENV PHP_INI_SCAN_DIR=/etc/php7/conf.d:/var/run/tuner/php

RUN apk update && \
    apk upgrade && \
    apk add apache2 \
            apache2-utils \
            bash \
            bash-completion \
            curl \
            jpegoptim \
            make \
            mysql-client \
            optipng \
            php7 \
            php7-apache2 \
            php7-apcu \
            php7-bcmath \
            php7-ctype \
            php7-curl \
            php7-dom \
            php7-ftp \
            php7-gd \
            php7-iconv \
            php7-json \
            php7-mbstring \
            php7-mcrypt \
            php7-memcached \
            php7-opcache \
            php7-openssl \
            php7-pcntl \
            php7-pdo \
            php7-pdo_mysql \
            php7-pdo_sqlite \
            php7-phar \
            php7-posix \
            php7-session \
            php7-simplexml \
            php7-soap \
            php7-sqlite3 \
            php7-tokenizer \
            php7-xml \
            php7-xmlreader \
            php7-xmlwriter \
            php7-zip \
            pngquant \
            rsync \
            unzip \
            vim \
            && \
    rm -rf /var/cache/apk/*

COPY .bashrc /root/.bashrc
COPY httpd.conf /etc/apache2/httpd.conf
COPY status.conf /etc/apache2/conf.d/status.conf
COPY security.conf /etc/apache2/conf.d/security.conf
COPY drushrc.php /etc/drush/drushrc.php
COPY apcu.ini /etc/php7/conf.d/apcu.ini

# Liveness
COPY liveness /var/www/liveness

# New Relic
RUN export NR_INSTALL_SILENT=true && \
    export NR_INSTALL_USE_CP_NOT_LN=true && \
    curl -sS http://download.newrelic.com/php_agent/release/newrelic-php5-8.1.0.209-linux-musl.tar.gz | gzip -dc | tar xf - && \
    cd newrelic-php5-8.1.0.209-linux-musl && ./newrelic-install install && \
    rm -fR /newrelic-php5-8.1.0.209-linux-musl
COPY newrelic.ini /etc/php7/conf.d/newrelic.ini

# Logging
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

# Tuner - https://github.com/previousnext/tuner
RUN curl -L https://github.com/previousnext/tuner/releases/download/1.0.0/tuner-linux-amd64 -o /usr/local/bin/tuner && \
    chmod +rx /usr/local/bin/tuner

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

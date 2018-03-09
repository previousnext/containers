ARG PHP_VERSION=7.0
FROM  php:${PHP_VERSION}-apache
LABEL maintainer="admin@previousnext.com.au"

WORKDIR /data

ENV PATH "$PATH:/data/bin"

# Apache + PHP
RUN apt-get update && \
    apt-get install  --no-install-recommends -y \
      mysql-client \
      zlib1g-dev \
      jpegoptim \
      libpng-dev \
      libmemcached-dev \
      libxml2-dev \
      libmcrypt-dev \
      optipng \
      openssh-client \
      wget \
      git \
      gnupg \
      vim \
      libfreetype6-dev \
      libjpeg-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# New Relic
RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list && \
    wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y newrelic-php5 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pecl install apcu
ADD apcu.ini /usr/local/etc/php/conf.d/apcu.ini

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install \
      zip \
      pdo \
      pdo_mysql \
      gd \
      mbstring \
      opcache \
      soap \
      pcntl \
      bcmath \
      mcrypt

RUN a2enmod rewrite actions negotiation headers authz_groupfile
ADD apache2.conf /etc/apache2/apache2.conf
ADD status.conf /etc/apache2/conf-enabled/status.conf
ADD other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
ADD php.ini /usr/local/etc/php/php.ini
# Removes other site specific configuration.
RUN rm -f /etc/apache2/sites-enabled/*

# Configuration
ADD drushrc.php /etc/drush/drushrc.php
ADD skpr.php /etc/skpr.php

# Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Tuner - https://github.com/previousnext/tuner
RUN curl -L https://github.com/previousnext/tuner/releases/download/1.0.0/tuner-linux-amd64 -o /usr/local/bin/tuner && \
      chmod +rx /usr/local/bin/tuner

# Backup - https://github.com/previousnext/skipper-backup
RUN curl -L https://github.com/previousnext/skipper-backup/releases/download/0.0.1/skipper-backup-linux-amd64 -o /usr/local/bin/backup && \
      chmod +rx /usr/local/bin/backup

# Script that kicks it all off
ADD start.sh /usr/local/bin/start
RUN chmod a+x /usr/local/bin/start

# New Relic.
ADD scripts/configure-new-relic.sh /usr/local/bin/configure-new-relic
RUN chmod a+x /usr/local/bin/configure-new-relic

# Cleanup.
RUN apt-get -y remove --purge \
      zlib1g-dev \
      libpng-dev \
      libmemcached-dev \
      libxml2-dev \
      libmcrypt-dev \
      libfreetype6-dev \
      libjpeg-dev \
      libc-dev-bin \
      libc6-dev \
      libgcc-4.9-dev \
      libstdc++-4.9-dev \
      linux-libc-dev \
      gcc \
      libgcc-4.9-dev \
      binutils \
      cpp \
      cpp-4.9

# Healthz checks.
COPY healthz /var/www/healthz

# Github.
RUN mkdir -p /root/.ssh && ssh-keyscan github.com >> /root/.ssh/known_hosts

CMD ["/usr/local/bin/start"]

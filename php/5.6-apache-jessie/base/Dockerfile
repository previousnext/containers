FROM  php:5.6-apache-jessie
LABEL maintainer="admin@previousnext.com.au"

WORKDIR /data

ENV PATH "$PATH:/data/bin"

# Apache + PHP
RUN apt-get update && \
    apt-get install -y \
      mysql-client \
      zlib1g-dev \
      jpegoptim \
      libpng-dev \
      libmcrypt-dev \
      libmemcached-dev \
      libxml2-dev \
      optipng \
      openssh-client \
      pngquant \
      vim \
      wget \
      git \
      libfreetype6-dev \
      libjpeg-dev \
      sendmail && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

# New Relic
RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list && \
    wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y newrelic-php5 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pecl install apcu-4.0.11
COPY apcu.ini /usr/local/etc/php/conf.d/apcu.ini
RUN pecl install memcached-2.2.0 && \
      echo 'extension = memcached.so' > /usr/local/etc/php/conf.d/memcached.ini

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install \
      zip \
      pdo \
      pdo_mysql \
      mcrypt \
      gd \
      mbstring \
      opcache \
      soap \
      pcntl \
      bcmath \
      mcrypt

RUN a2enmod rewrite actions negotiation headers authz_groupfile
COPY apache2.conf /etc/apache2/apache2.conf
COPY security.conf /etc/apache2/conf-enabled/security.conf
COPY status.conf /etc/apache2/conf-enabled/status.conf
COPY other-vhosts-access-log.conf /etc/apache2/conf-enabled/other-vhosts-access-log.conf
COPY php.ini /usr/local/etc/php/php.ini
# Removes other site specific configuration.
RUN rm -f /etc/apache2/sites-enabled/*

# Configuration
COPY drushrc.php /etc/drush/drushrc.php
COPY skpr.php /etc/skpr.php

# Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Add Amazon RDS TLS public certificate.
ADD https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem  /etc/ssl/certs/rds-combined-ca-bundle.pem
RUN chmod 755 /etc/ssl/certs/rds-combined-ca-bundle.pem

# Tuner - https://github.com/previousnext/tuner
RUN curl -L https://github.com/previousnext/tuner/releases/download/1.0.0/tuner-linux-amd64 -o /usr/local/bin/tuner && \
      chmod +rx /usr/local/bin/tuner

# Backup - https://github.com/previousnext/skipper-backup
RUN curl -L https://github.com/previousnext/skipper-backup/releases/download/0.0.1/skipper-backup-linux-amd64 -o /usr/local/bin/backup && \
      chmod +rx /usr/local/bin/backup

# Script that kicks it all off
COPY start.sh /usr/local/bin/start
RUN chmod a+x /usr/local/bin/start

# New Relic.
COPY scripts/configure-new-relic.sh /usr/local/bin/configure-new-relic
RUN chmod a+x /usr/local/bin/configure-new-relic

# Cleanup.
RUN apt-get -y remove --purge \
      zlib1g-dev \
      libpng-dev \
      libmcrypt-dev \
      libmemcached-dev \
      libxml2-dev \
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

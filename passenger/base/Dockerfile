FROM       ubuntu:16.04
MAINTAINER nick_schuch

WORKDIR /data

ENV DEBIAN_FRONTEND=noninteractive

# https://www.phusionpassenger.com/library/install/apache/install/oss/xenial/#step-1:-install-passenger-packages
RUN apt-get update && \
    apt-get install -y software-properties-common ca-certificates apt-transport-https && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 && \
    echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main" > /etc/apt/sources.list.d/passenger.list

RUN apt-get update && \
    apt-get install -y \
      apache2 \
      bash-completion \
      curl \
      git \
      imagemagick \
      libapache2-mod-passenger \
      libapr1-dev \
      libaprutil1-dev \
      libcurl4-openssl-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libmysqlclient-dev \
      libsqlite3-dev \
      libssl-dev \
      libxml2-dev \
      libxslt-dev \
      mysql-client \
      ruby-json \
      ruby-libxml \
      ruby-mysql \
      ruby-nokogiri \
      ruby-rmagick \
      ruby2.3 \
      ruby2.3-dev \
      tzdata \
      zlib1g-dev && \
    apt-get clean

RUN gem install bundler

# Enable STDOUT and STDERR.
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

RUN a2enmod passenger rewrite headers
ADD vhost.conf /etc/apache2/sites-enabled/000-default.conf
COPY apache2-foreground /usr/local/bin/

# Tuner - https://github.com/previousnext/tuner
RUN curl -L https://github.com/previousnext/tuner/releases/download/1.0.0/tuner-linux-amd64 -o /usr/local/bin/tuner && \
      chmod +rx /usr/local/bin/tuner

# Backup - https://github.com/previousnext/skipper-backup
RUN curl -L https://github.com/previousnext/skipper-backup/releases/download/0.0.1/skipper-backup-linux-amd64 -o /usr/local/bin/backup && \
      chmod +rx /usr/local/bin/backup

# Script that kicks it all off
ADD start.sh /usr/local/bin/start
RUN chmod a+x /usr/local/bin/start

# These get run on build.
ONBUILD ADD . /data
ONBUILD RUN chown -R www-data:www-data /data

CMD ["start"]

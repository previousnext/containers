FROM alpine:3.7

ENV PATH "$PATH:/data/bin"

RUN PACKAGES="apache2 apache2-ctl apache2-dev apache2-utils bash bash-completion curl make mysql-client rsync ruby-bundler unzip vim " && \
    BUILD_PACKAGES="build-base ruby-dev linux-headers curl-dev pcre-dev ruby-dev libexecinfo-dev zlib-dev" && \
    export EXTRA_PRE_CFLAGS='-O' EXTRA_PRE_CXXFLAGS='-O' EXTRA_LDFLAGS='-lexecinfo' && \
    apk update && \
    apk upgrade && \
    apk add --no-cache $PACKAGES $BUILD_PACKAGES && \
    gem install passenger --no-rdoc --no-ri && \
    passenger-install-apache2-module --auto && \
    passenger-config validate-install --auto && \
    export PASSENGER_PATH=$(VISUAL=echo gem open passenger) && \
    rm -rf /tmp/* && \
    mv $PASSENGER_PATH/src/ruby_supportlib $PASSENGER_PATH/src/nodejs_supportlib $PASSENGER_PATH/src/helper-scripts /tmp && \
    rm -rf $PASSENGER_PATH/src/* && \
    mv /tmp/* $PASSENGER_PATH/src/ && \
    apk del $BUILD_PACKAGES \

# Configure passenger
ADD passenger.conf /etc/apache2/conf.d/passenger.conf
RUN export PASSENGER_PATH=$(VISUAL=echo gem open passenger) && \
    sed -i -e "s#PASSENGER_PATH#$PASSENGER_PATH#g" /etc/apache2/conf.d/passenger.conf

# Tuner - https://github.com/previousnext/tuner
RUN curl -L https://github.com/previousnext/tuner/releases/download/1.0.0/tuner-linux-amd64 -o /usr/local/bin/tuner && \
    chmod +rx /usr/local/bin/tuner

# These volumes allow us to run our containers in "readonly" mode.
VOLUME /run/apache2
VOLUME /run/lock/apache2
VOLUME /tmp
VOLUME /var/log/newrelic
VOLUME /var/run/tuner/apache2

WORKDIR /data

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

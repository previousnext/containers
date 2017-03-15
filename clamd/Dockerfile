FROM       alpine:3.3
MAINTAINER Nick Schuch

ENV DEBIAN_FRONTEND noninteractive

RUN apk update && \
    apk add -u clamav-daemon python py-pip wget clamav-libunrar unrar

RUN wget -O /var/lib/clamav/main.cvd http://database.clamav.net/main.cvd && \
    wget -O /var/lib/clamav/daily.cvd http://database.clamav.net/daily.cvd && \
    wget -O /var/lib/clamav/bytecode.cvd http://database.clamav.net/bytecode.cvd && \
    chown clamav:clamav /var/lib/clamav/*.cvd && \
    mkdir /run/clamav && \
    chown clamav:clamav /run/clamav

ADD clamd.conf /etc/clamav/clamd.conf

EXPOSE 3310

CMD ["clamd"]

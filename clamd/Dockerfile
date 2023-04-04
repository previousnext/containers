FROM  alpine:3.3
LABEL maintainer="admin@previousnext.com.au"

ENV DEBIAN_FRONTEND noninteractive

RUN apk add --no-cache -u clamav-daemon python py-pip wget clamav-libunrar unrar

RUN wget -nv -O /var/lib/clamav/main.cvd https://database.clamav.net/main.cvd && \
    wget -nv -O /var/lib/clamav/daily.cvd https://database.clamav.net/daily.cvd && \
    wget -nv -O /var/lib/clamav/bytecode.cvd https://database.clamav.net/bytecode.cvd && \
    chown clamav:clamav /var/lib/clamav/*.cvd && \
    mkdir /run/clamav && \
    chown clamav:clamav /run/clamav

COPY clamd.conf /etc/clamav/clamd.conf

EXPOSE 3310

CMD ["clamd"]

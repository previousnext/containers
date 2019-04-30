FROM debian:jessie

ENV PHANTOMJS_VERSION 2.1.1
ENV PHANTOMJS_HASH "f8afc8a24eec34c2badccc93812879a3d6f2caf3 phantomjs-2.1.1-linux-x86_64.tar.bz2"

WORKDIR /usr/local

RUN RUN sed -i '/jessie-updates/d' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    wget \
    ca-certificates \
    bzip2 \
    libfontconfig \
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3003
RUN cd /tmp && \
    echo $PHANTOMJS_HASH > phantomjs.sha1 && \
    wget --quiet https://s3-ap-southeast-2.amazonaws.com/pnx-misc/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    sha1sum -c phantomjs.sha1 && \
    tar -xvf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
    mv phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2

# hadolint ignore=DL3003
RUN mkdir /data && \
    cd /tmp && \
    wget https://github.com/jcalderonzumba/gastonjs/archive/v1.0.2.zip && \
    unzip v1.0.2.zip && \
    mv gastonjs-1.0.2 /data/gastonjs

EXPOSE 8510

CMD ["/usr/local/bin/phantomjs", "--ssl-protocol=any", "--ignore-ssl-errors=true", "/data/gastonjs/src/Client/main.js", "8510", "1024", "768"]

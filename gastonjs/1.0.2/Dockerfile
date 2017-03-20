FROM debian:jessie

ENV PHANTOMJS_VERSION 2.1.1
ENV PHANTOMJS_HASH "f8afc8a24eec34c2badccc93812879a3d6f2caf3 phantomjs-2.1.1-linux-x86_64.tar.bz2"

WORKDIR /usr/local

RUN apt-get update && \
    apt-get install -y wget bzip2 libfontconfig unzip && \
    apt-get clean

RUN cd /tmp && \
    echo $PHANTOMJS_HASH > phantomjs.sha1 && \
    wget https://cnpmjs.org/mirrors/phantomjs/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
    sha1sum -c phantomjs.sha1 && \
    tar -xvf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
    mv phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2

RUN mkdir /data && \
    cd /tmp && \
    wget https://github.com/jcalderonzumba/gastonjs/archive/v1.0.2.zip && \
    unzip v1.0.2.zip && \
    mv gastonjs-1.0.2 /data/gastonjs

EXPOSE 8510

CMD ["/usr/local/bin/phantomjs", "--ssl-protocol=any", "--ignore-ssl-errors=true", "/data/gastonjs/src/Client/main.js", "8510", "1024", "768"]
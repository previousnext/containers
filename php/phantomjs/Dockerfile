FROM debian:jessie

WORKDIR /usr/local

RUN apt-get update && \
    apt-get install -y wget bzip2 libfontconfig git && \
    apt-get clean

RUN cd /tmp && \
    echo "f8afc8a24eec34c2badccc93812879a3d6f2caf3  phantomjs-2.1.1-linux-x86_64.tar.bz2" > phantomjs.sha1 && \
    wget https://cnpmjs.org/mirrors/phantomjs/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    sha1sum -c phantomjs.sha1 && \
    tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm phantomjs-2.1.1-linux-x86_64.tar.bz2

RUN git clone --depth=1 https://github.com/jcalderonzumba/gastonjs /data/gastonjs

EXPOSE 8510

CMD ["/usr/local/bin/phantomjs", "--ssl-protocol=any", "--ignore-ssl-errors=true", "/data/gastonjs/src/Client/main.js", "8510", "1024", "768"]
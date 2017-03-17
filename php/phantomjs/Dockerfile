FROM previousnext/php:7.1

WORKDIR /usr/local

# bzip2 is required for phantomjs extract, libfontconfig for phantomjs
RUN apt-get update && \
    apt-get install -y bzip2 libfontconfig && \
    apt-get clean

RUN cd /tmp && \
    echo "f8afc8a24eec34c2badccc93812879a3d6f2caf3  phantomjs-2.1.1-linux-x86_64.tar.bz2" > phantomjs.sha1 && \
    wget https://cnpmjs.org/mirrors/phantomjs/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    sha1sum -c phantomjs.sha1 && \
    tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm phantomjs-2.1.1-linux-x86_64.tar.bz2

RUN composer require behat/mink:~1.7 && \
    composer require jcalderonzumba/gastonjs:~1.1.0 && \
    composer require jcalderonzumba/mink-phantomjs-driver:~0.3.1

EXPOSE 8510

CMD ["/usr/local/bin/phantomjs", "--ssl-protocol=any", "--ignore-ssl-errors=true", "./vendor/jcalderonzumba/gastonjs/src/Client/main.js", "8510", "1024", "768"]
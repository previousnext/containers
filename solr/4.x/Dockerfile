FROM  alpine:3.4
LABEL maintainer="admin@previousnext.com.au"

ENV SOLR_VERSION 4.9.1
ENV SOLR_HEAP 256m

RUN apk add --no-cache openjdk7-jre tar wget

WORKDIR /tmp
RUN wget -nv http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz && \
 	tar -C /tmp --extract --file /tmp/solr-$SOLR_VERSION.tgz && \
 	rm /tmp/solr-$SOLR_VERSION.tgz && \
    mkdir -p /opt && \
    mv /tmp/solr-$SOLR_VERSION /opt/solr && \
    mv /opt/solr/example /opt/solr/core

# Drupal specific configuration provided by
# http://cgit.drupalcode.org/search_api_solr/tree/solr-conf/4.x
COPY conf/solr /opt/search_api
RUN mv /opt/search_api/* /opt/solr/core/solr/collection1/conf/ && \
    rm -fR /opt/search_api

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

# Where we store our persistent data.
RUN mkdir /opt/solr/data

WORKDIR /
EXPOSE 8983

CMD ["/entrypoint.sh"]

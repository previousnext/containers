FROM        alpine:3.4
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

ENV SOLR_VERSION 4.9.1
ENV JAVA_MEMORY 256m

RUN apk add --no-cache openjdk7-jre tar wget

RUN cd /tmp && \
	wget http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz && \
 	tar -C /tmp --extract --file /tmp/solr-$SOLR_VERSION.tgz && \
 	rm /tmp/solr-$SOLR_VERSION.tgz && \
    mkdir -p /opt && \
    mv /tmp/solr-$SOLR_VERSION /opt/solr && \
    mv /opt/solr/example /opt/solr/core

# Drupal specific configuration provided by
# http://cgit.drupalcode.org/search_api_solr/tree/solr-conf/4.x
ADD conf/solr /opt/search_api
RUN mv /opt/search_api/* /opt/solr/core/solr/collection1/conf/ && \
    rm -fR /opt/search_api

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 8983

CMD ["/entrypoint.sh"]

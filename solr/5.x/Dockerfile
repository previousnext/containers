FROM        solr:5.5.4
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

ENV JAVA_MEMORY 256m
ENV SOLR_HEAP="256m"

ADD conf /opt/search_api

ADD scripts/heap.sh /docker-entrypoint-initdb.d/set-heap.sh

RUN start-local-solr && \
      /opt/solr/bin/solr create -c solr -d /opt/search_api && \
      stop-local-solr

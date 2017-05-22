FROM        solr:5.5.4
MAINTAINER  Nick Schuch <nick@previousnext.com.au>

ENV SOLR_HEAP="256m"

ADD conf /opt/search_api

ADD scripts/heap.sh /docker-entrypoint-initdb.d/set-heap.sh

# Where we store our persistent data.
RUN mkdir /opt/solr/data

RUN start-local-solr && \
      /opt/solr/bin/solr create -c solr -d /opt/search_api && \
      stop-local-solr
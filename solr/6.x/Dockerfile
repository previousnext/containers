FROM  solr:5.5.4
LABEL maintainer="admin@previousnext.com.au"

ENV SOLR_HEAP="256m"

ADD conf /opt/search_api

ADD scripts/heap.sh /docker-entrypoint-initdb.d/set-heap.sh

# Where we store our persistent data so we can swap it for mounted storage.
RUN mkdir /opt/solr/data

RUN start-local-solr && \
      /opt/solr/bin/solr create -c drupal -d /opt/search_api && \
      stop-local-solr

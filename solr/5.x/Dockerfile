FROM  solr:5.5
LABEL maintainer="admin@previousnext.com.au"

ENV SOLR_HEAP="256m"
ENV SOLR_CORE="drupal"

COPY conf /opt/search_api

COPY scripts/heap.sh /docker-entrypoint-initdb.d/set-heap.sh
COPY scripts/core.sh /docker-entrypoint-initdb.d/set-core.sh

# Where we store our persistent data so we can swap it for mounted storage.
RUN mkdir /opt/solr/data

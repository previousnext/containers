FROM  solr:5.5

ENV SOLR_CORE="drupal"

ENV SOLR_HEAP="256m"
ENV SOLR_JAVA_MEM="-Xms256m -Xmx256m"
ENV JVM_OPTS="-Xms256m -Xmx256m"

COPY search_api /search_api

COPY scripts/heap.sh /docker-entrypoint-initdb.d/set-heap.sh

CMD ["/bin/bash", "-c", "solr-precreate ${SOLR_CORE} /search_api"]

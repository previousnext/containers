FROM  solr:7
LABEL maintainer="admin@previousnext.com.au"

ENV SOLR_HEAP="256m"
ENV SOLR_CORE="drupal"

COPY --chown=solr:solr conf /opt/search_api
COPY --chown=solr:solr scripts/core.sh /docker-entrypoint-initdb.d/set-core.sh

VOLUME /opt/solr/server/solr/mycores

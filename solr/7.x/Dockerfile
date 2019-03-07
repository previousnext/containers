FROM  solr:7
LABEL maintainer="admin@previousnext.com.au"

ENV SOLR_HEAP="256m"
ENV SOLR_CORE="drupal"
ENV SOLR_DATA=/var/solr

COPY --chown=solr:solr conf /opt/search_api
COPY --chown=solr:solr scripts/core.sh /docker-entrypoint-initdb.d/set-core.sh

# Where we store our persistent data so we can swap it for mounted storage.
USER root
RUN mkdir ${SOLR_DATA} && \
  chown -R solr:solr ${SOLR_DATA}
USER solr
VOLUME ${SOLR_DATA}

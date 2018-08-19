FROM debian:9.5-slim
LABEL maintainer="admin@previousnext.com.au"

ENV SOLR_USER="solr"
ENV SOLR_UID="8983"
ENV SOLR_GROUP="solr"
ENV SOLR_GID="8983"

# https://github.com/docker-solr/docker-solr/blob/4ed56419308ecee62149a65db8b4b9ef7fab05c1/5.5/Dockerfile
RUN groupadd -r --gid $SOLR_GID $SOLR_GROUP && \
    useradd -r --uid $SOLR_UID --gid $SOLR_GID $SOLR_USER

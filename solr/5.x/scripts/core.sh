#!/bin/bash

# Name:        core.sh
# Description: Sets up the Solr core. Default SOLR_CORE set in Dockerfile.

start-local-solr && \
  /opt/solr/bin/solr create -c $SOLR_CORE -d /opt/search_api && \
  stop-local-solr

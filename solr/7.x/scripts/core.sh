#!/bin/bash

# Name:        core.sh
# Description: Sets up the Solr core. Default SOLR_CORE set in Dockerfile.

FILE=/opt/solr/provisioned

if [ -f "${FILE}" ]; then
  echo "The core was already provisioned"
  return
fi

precreate-core $SOLR_CORE /opt/search_api

echo $(date) > $FILE

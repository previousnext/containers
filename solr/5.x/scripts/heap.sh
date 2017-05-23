#!/bin/bash

# Name:        heap.sh
# Description: Sets the Solr heap size (memory). Default SOLR_HEAP set in Dockerfile.

sed -i -e "s/SOLR_HEAP=\".*\"/SOLR_HEAP=\"${SOLR_HEAP}\"/g" /opt/solr/bin/solr.in.sh

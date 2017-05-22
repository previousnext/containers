#!/bin/bash

sed -i -e "s/SOLR_HEAP=\".*\"/SOLR_HEAP=\"${SOLR_HEAP}\"/g" /opt/solr/bin/solr.in.sh

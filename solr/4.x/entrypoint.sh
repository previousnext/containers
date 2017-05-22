#!/bin/sh

# Name:    entrypoint.sh
# Comment: First command to run on container boot.
# Author:  Nick Schuch

cd /opt/solr/core

java -Xms${SOLR_HEAP} -Xmx${SOLR_HEAP} -jar start.jar

#!/bin/sh

# Name:    entrypoint.sh
# Comment: First command to run on container boot.
# Author:  Nick Schuch

cd /opt/solr/core

java -Xmx${JAVA_MEMORY} -jar start.jar

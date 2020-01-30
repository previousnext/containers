#!/bin/bash

# Name:        blackfire.sh
# Description: Enables Blackfire profiling.

if [ "$BLACKFIRE_ENABLED" != "yes" ]; then
  echo "Skipping Backfire: Set BLACKFIRE_ENABLED=yes to enable"
  exit 0
fi

echo "Enabling Blackfire"
mv /etc/php7/conf.d/example/blackfire.ini /etc/php7/conf.d/blackfire.ini

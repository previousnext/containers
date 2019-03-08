#!/bin/bash

# Name:        xdebug.sh
# Description: Enables Xdebug.

if [ "$XDEBUG_ENABLED" != "yes" ]; then
  echo "Skipping Xdebug: Set XDEBUG_ENABLED=yes to enable"
  exit 0
fi

echo "Enabling Xdebug"
mv /etc/php7/conf.d/example/xdebug.ini /etc/php7/conf.d/xdebug.ini
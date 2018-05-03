#!/bin/bash

# Name:    start.sh
# Author:  Nick Schuch
# Comment: A lightweight script for configuring and starting Apache

if [ -f /etc/skpr/nr.install.key ]; then
  export NEW_RELIC_LICENSE_KEY=$(cat /etc/skpr/nr.install.key 2> /dev/null)
  echo "New Relic: Found Skipper config: nr.install.key"
fi

if [ -f /etc/skpr/nr.app.name ]; then
  export NEW_RELIC_APP_NAME=$(cat /etc/skpr/nr.app.name 2> /dev/null)
  echo "New Relic: Found Skippr config: nr.app.name"
fi

if [ "$NEW_RELIC_LICENSE_KEY" != "" ] && [ "$NEW_RELIC_APP_NAME" != "" ]; then
  export NEW_RELIC_ENABLED=true
  echo "New Relic: Enabled"
fi

mkdir -p /var/run/tuner/{apache2,php}
tuner --conf=apache > /var/run/tuner/apache2/tuner.conf
tuner --conf=php > /var/run/tuner/php/tuner.ini

httpd -D FOREGROUND

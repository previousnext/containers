#!/bin/bash

# Name:        configure-new-relic.sh
# Author:      Nick Schuch
# Description: Configure New Relic for this environment.

export NR_INSTALL_SILENT=true
export NR_INSTALL_KEY=$(cat /etc/skpr/nr.install.key 2> /dev/null)
export NR_APP_NAME=$(cat /etc/skpr/nr.app.name 2> /dev/null)

if [ "$NR_INSTALL_KEY" != "" ] && [ "$NR_APP_NAME" != "" ]; then
  echo "[NEW RELIC] Installing..."
  newrelic-install install

  echo "[NEW RELIC] Configuring..."
  sed -i "s/newrelic.appname = \"PHP Application\"/newrelic.appname = \"${NR_APP_NAME}\"/" /usr/local/etc/php/conf.d/newrelic.ini

  echo "[NEW RELIC] Complete!"
else
  echo "[NEW RELIC] Skipping..."
fi

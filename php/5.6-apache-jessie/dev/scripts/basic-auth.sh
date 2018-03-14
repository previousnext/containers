#!/bin/bash

# Name:    basic-auth.sh
# Author:  Nick Schuch
# Comment: Script for configuring Basic Auth

if [ "$BASIC_AUTH_USER" == "" ]; then
  exit 0
fi

if [ "$BASIC_AUTH_PASS" == "" ]; then
  exit 0
fi

mkdir -p /etc/htpasswd
htpasswd -b -c /etc/htpasswd/.htpasswd $BASIC_AUTH_USER $BASIC_AUTH_PASS
cat >/etc/apache2/conf-enabled/basic-auth.conf <<EOL
<Location "/">
  AuthType Basic
  AuthName "Authentication Required"
  AuthUserFile /etc/htpasswd/.htpasswd
  Require valid-user

  Order allow,deny
  Allow from all
</Location>
EOL
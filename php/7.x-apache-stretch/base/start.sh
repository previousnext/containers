#!/bin/bash

# Name:    start.sh
# Author:  Nick Schuch
# Comment: A lightweight script for configuring and starting Apache

configure-new-relic

tuner --conf=apache > /etc/apache2/mods-enabled/tuner.conf
tuner --conf=php > /usr/local/etc/php/conf.d/tuner.ini

apache2-foreground

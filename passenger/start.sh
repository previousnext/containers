#!/bin/bash

# Name:    start.sh
# Author:  Nick Schuch
# Comment: A lightweight script for configuring and starting Apache

tuner --conf=passenger > /etc/apache2/mods-enabled/tuner.conf

apache2-foreground

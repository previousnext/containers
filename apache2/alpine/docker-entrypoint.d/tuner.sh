#!/bin/bash

# Name:    tuner.sh
# Author:  Nick Schuch
# Comment: Configure Apache + PHP based on resources.

echo "Tuning: Apache: /var/run/tuner/apache2/tuner.conf"
tuner --conf=apache > /var/run/tuner/apache2/tuner.conf

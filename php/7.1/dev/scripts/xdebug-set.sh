#!/bin/sh

XDEBUG_SO=$(ls /usr/local/lib/php/extensions/*/xdebug.so | head -n1)

sed -i -e "s/XDEBUG_SO/${XDEBUG_SO}/g" $1
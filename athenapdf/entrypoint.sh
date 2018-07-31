#!/bin/bash
set -e

rm -f /tmp/.X99-lock
export DISPLAY=:99

exec "$@"
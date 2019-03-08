#!/bin/bash

DIR=/docker-entrypoint.d

if [[ -d "$DIR" ]]; then
  for f in $DIR/*.sh; do
    echo "Running entrypoint.d script: $f"
    bash "$f" -H   || break
  done
fi

exec "$@"

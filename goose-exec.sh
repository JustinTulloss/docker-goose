#!/usr/bin/env bash
# A wrapper script for `goose` that sets up environment variables

# Default values for environment variables
: "${GOOSE_ENV:=default}"

if [ -n "${DEBUG+x}" ]; then
  echo "Settings:"
  echo "    GOOSE_ENV: $GOOSE_ENV"
fi

/go/bin/goose --env="$GOOSE_ENV" "$@"

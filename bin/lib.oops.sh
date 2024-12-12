#!/usr/bin/env bash
# fail with an error message
# Useful with piped OR operator:
#   command || oops "exit with a message"
#   command || oops "exit with return code 12" 12
oops() {
  logg err "$1"
  if [ $# -eq 2 ]; then
    exit "$2"
  else
    exit 10
  fi
}

export -f oops

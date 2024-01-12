#!/usr/bin/env bash
# Display messages with colors.
#
# $1 is the type of message (command|fail|success|warn|debug|kv|normal)
# $2 is the message
#
# if $1 is "kv", $2 is the key, $3 is the value
DEBUG=true

rflog () {
  logtype=$1
  shift
  case "$logtype" in
    nl|.)
      # New line
      printf -- "\n"
      ;;
    command|cmd|code)
      # Indent and dim
      printf -- "  \033[2m%s\033[22m\n" "$@"
      ;;
    fail|f|e|red|err|n)
      # Red
      printf -- "\033[31m%s\033[0m\n" "$@"
      ;;
    success|yes|green|y|s)
      # Green
      printf -- "\033[32m%s\033[0m\n" "$@"
      ;;
    info|blue|i)
      # dim
      printf -- "\033[2m%s\033[22m\n" "$@"
      ;;
    warn|w|orange)
      # Orange
      printf -- "\033[33m%s\033[0m\n" "$@"
      ;;
    debug|d|grey)
      # Grey
      [[ "$DEBUG" = "true" ]] && printf -- "\033[90m%s\033[0m\n" "$@"
      ;;
    keyval|kv)
      # Bold cyan for the key, value is normal.
      key=$1
      shift
      if [ -z "$1" ]; then
        printf -- "\033[36;1m%s=\033[31m<UNDEF!>\033[0m\n" "$key"
      else
        printf -- "\033[36;1m%s=\033[0m%s\n" "$key" "$@"
      fi
      ;;
    *)
      # Normal
      printf -- "%s\n" "%s"
      ;;
  esac
}

export -f rflog
export DEBUG

# shellcheck source=../minimicsrc.dist
. "${HOME}"/.minimicsrc

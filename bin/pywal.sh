#!/bin/sh
# Wrapper to launch pywal
#
# You must add the following variable to your .minimicsrc:
#   export MINIMICS_WALLS=<path to wallpaper directory or file>
set -eu
. "${HOME}"/.minimicsrc

mode=${1:-normal}
if [ "${mode}" = "restore" ] || [ "${mode}" = "-R" ]; then

  # Restore previous configuration
  wal -q -R

else

  # Fail if wallpapers directory/file does not exist
  if [ ! -e "${MINIMICS_WALLS}" ]; then
    echo "ERROR:"
    echo "Folder / file containing wallpaper(s) is undefined or does not exist."
    echo
    echo "  MINIMICS_WALLS=${MINIMICS_WALLS}"
    echo
    echo "Please update your .minimicsrc"
    exit 1
  fi

  # Run pywal
  wal -q -i "${MINIMICS_WALLS}"

fi

# Run pywal-discord if exists
if which pywal-discord > /dev/null 2>&1; then
  pywal-discord
fi

exit 0

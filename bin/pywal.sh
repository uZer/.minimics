#!/bin/bash
#
# Wrapper to launch pywal
# You must configure the following variable to your .minimicsrc:
# export MINIMICS_WALLS=<path to wallpaper directory or file>

set -eu

# shellcheck source=../minimicsrc.dist
. "${HOME}/.minimicsrc"

# wal settings
# wal="exec $(which wal) --cols16 -b 0A0A0A"
# wal="exec $(which wal) --cols16 -b 0A0F14"
wal="$(which wal) --cols16"
backend=fast-colorthief

# Mode is defined in first argument.
# Defaults to wall restore
mode=${1:-restore}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

# Fail if wallpapers directory/file does not exist
check_wall_folder () {
  if [ ! -e "${MINIMICS_WALLS}" ]; then
    echo "ERROR:"
    echo "Folder / file containing wallpaper(s) is undefined or does not exist."
    echo
    echo "  MINIMICS_WALLS=${MINIMICS_WALLS}"
    echo
    echo "Please update your .minimicsrc"
    exit 1
  fi
  return
}

# Fail if dwall is not present or dwall path is not defined
check_dwall_folder () {
  if [ ! -d "${MINIMICS_DWALL}" ]; then
    echo "ERROR:"
    echo "Folder / file containing dwall is undefined or does not exist."
    echo
    echo "  MINIMICS_DWALL=${MINIMICS_DWALL}"
    echo
    echo "Please update your .minimicsrc"
    exit 1
  fi
  return
}

# Restore previous wal colors
wal_restore () {
  ${wal} -R
}

# Refresh discord theme
wal_discord () {
  if which pywal-discord > /dev/null 2>&1; then
    pywal-discord
  fi
}

# Refresh firefox theme
wal_fox () {
  if which pywalfox > /dev/null 2>&1; then
    pywalfox update
  fi
}

# Use predefined colorscheme
# $1 is the colorscheme name
wal_colorscheme () {
  ${wal} -f "${@}"
}

# Use dwall based on current time
# $1 is the name of the theme to use
wal_time () {
  hour=$(date +%-H)
  ${wal} -i "${MINIMICS_DWALL}/images/$1/${hour}.jpg" "${@:2}"
}

# Classic pywal
wal_folder () {
  ${wal} -i "${MINIMICS_WALLS}" --iterative --backend "${backend}" "${@}"
}

# Halp
display_help () {
  cat << EOF
A small wrapper to apply or restore a colorscheme with pywal.
Requires configuration in ~/.minimicsrc.

Usage:

  # Restore previous pywal settings and display current colors

    $0

  # Use a predefined colorscheme

    $0 <colorscheme>

  # Use a time based dwall theme.
  # Default to lakeside theme.

    $0 time <theme>
    $0 -t   <theme>

  # Generate a colorscheme from a folder defined in ~/.minimicsrc

    $0 folder

List of available dwall themes:
$(find "${MINIMICS_DWALL}/images" -mindepth 1 -maxdepth 1 -type d -printf %f\\n | sort | xargs)
EOF
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

case "${mode}" in

  # Display help
  help|--help|-h)
    display_help
    ;;

  # Restore current configuration (useful for remote shells)
  restore|-r|-R)
    wal_restore
    wal_discord
    wal_fox
    ;;

  # Generate a colorscheme from a random wallpaper in the folder or filelist
  folder|-f)
    check_wall_folder
    wal_folder "${@:2}"
    wal_discord
    wal_fox
    ;;

  # Use a dwall theme
  time|-t)
    shift
    check_dwall_folder
    wal_time "${2:-lakeside}" "${@:3}"
    wal_fox
    ;;

  # Use a predefined colorscheme
  *)
    wal_colorscheme "${mode}" "${@:2}"
    wal_discord
    wal_fox
    ;;

esac

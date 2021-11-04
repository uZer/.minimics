#!/bin/sh
#
# Wrapper to launch pywal
# You must configure the following variable to your .minimicsrc:
# export MINIMICS_WALLS=<path to wallpaper directory or file>

set -eu
. "${HOME}/.minimicsrc"

# wal settings
wal=$(which wal)
backend=colorz

# Mode is defined in first argument.
# Defaults to wall folder classic rotation.
mode=${1:-folder}


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
  ${wal} -q -R
}

# Refresh discord theme
wal_discord () {
  if which pywal-discord > /dev/null 2>&1; then
    pywal-discord
  fi
  return
}

# Use predefined colorscheme
# $1 is the colorscheme name
wal_colorscheme () {
  ${wal} -q -f "$1"
  return
}

# Use dwall based on current time
# $1 is the name of the theme to use
wal_time () {
  hour=$(date +%-H)
  ${wal} -q -i "${MINIMICS_DWALL}/images/$1/${hour}.jpg"
  return
}

# Classic pywal
wal_folder () {
  # ${wal} -q -i "${MINIMICS_WALLS}" --iterative
  ${wal} -q -i "${MINIMICS_WALLS}" --iterative --backend ${backend} -b 001019
  return
}

# Halp
display_help () {
  cat << EOF
A small wrapper to apply a colorscheme with pywal or restore pywal configuration

Usage:

  # Restore previous pywal settings

    $0 restore
    $0 -r

  # Use a predefined colorscheme

    $0 <colorscheme>

  # Use a time based dwall theme.
  # Default to lakeside theme.

    $0 time <theme>
    $0 -t   <theme>

  # Generate a colorscheme from a folder

    $0 folder
    $0 -f

List of available dwall themes:
$(ls -1 ${MINIMICS_DWALL}/images | xargs)
EOF
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

case "${mode}" in

  # Display help
  help|--help|-h)
    display_help
    exit 0
    ;;

  # Restore current configuration (useful for remote shells)
  restore|-r|-R)
    wal_restore
    wal_discord
    exit 0
    ;;

  # Generate a colorscheme from a random wallpaper in the folder or filelist
  folder|-f)
    check_wall_folder
    wal_folder
    wal_discord
    exit 0
    ;;

  # Use a dwall theme
  time|-t)
    shift
    check_dwall_folder
    wal_time "${1:-lakeside}"
    wal_discord
    exit 0
    ;;

  # Use a predefined colorscheme
  *)
    wal_colorscheme "${mode}"
    wal_discord
    exit 0
    ;;

esac

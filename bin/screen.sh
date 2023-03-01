#!/bin/bash
#
# Manage screens
# Type xrandr to get correct screen names

set -eu
. "${HOME}/.minimicsrc"

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

###################
## CONFIGURATION ##
###################

# Configure screens
screen1_name="${MINIMICS_SCREEN1_NAME:-eDP1}"
screen1_resolution="${MINIMICS_SCREEN1_RESOLUTION:-1366x768}"
screen2_name="${MINIMICS_SCREEN2_NAME:-HDMI2}"
screen2_resolution="${MINIMICS_SCREEN2_RESOLUTION:-1920x1080}"
screen3_name="${MINIMICS_SCREEN3_NAME:-HDMI3}"
screen3_resolution="${MINIMICS_SCREEN3_RESOLUTION:-1920x1080}"

# Position: left-of, right-of, above, below
screen2_position="${MINIMICS_SCREEN2_POSITION:-left-of}"
screen3_position="${MINIMICS_SCREEN3_POSITION:-left-of}"

# List of available modes
modelist=(single_screen1 single_screen2 single_screen3 dual_split dual_clone rf)

# Split or clone by default
mode=${1:-single_screen1}

# Halp
display_help () {
  cat << EOF
Configure displays with xrandr.

If only one screen is connected, this script will disable other screens and
set the resolution specified in the configuration.

Otherwise, you can choose a display mode:
  $(echo ${modelist[@]} | sed 's/ /\n  /g')

Example:
  $ $(basename "$0") dual_split

EOF
}

if [ $# -eq 1 ] && [ "${1}" == "-h" ] || [ "${1}" == "--help" ]; then
  display_help
  exit 1
fi

# Display available options for rofi applets
options () {
  single_screen1=" ;single_screen1"
  single_screen2=" ;single_screen2"
  single_screen3=" ;single_screen3"
  dual_split=" ;dual_split"
  dual_clone=" ;dual_clone"
  printf '%s\n%s\n%s\n%s\n%s\n' \
    "${single_screen1}" \
    "${single_screen2}" \
    "${single_screen3}" \
    "${dual_split}" \
    "${dual_clone}"
}

# Reload bars
reload_bars () {
  ~/.minimics/bin/polybar.sh
}

# Disable allscreens but the ones listed
cleanup_but () {
  keep=$1
  xrandr --listmonitors | \
    grep -v Monitors | \
    awk '{ print $4 }' | \
    grep -E -v "^${keep}$" | \
     xargs -n 1 xrandr --output "$1" --off \
    > /dev/null 2>&1
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

#################
## SCREEN MODS ##
#################

# Disable screen 2 and 3, only use screen 1
single_screen1 () {
  xrandr \
    --output "${screen1_name}" --auto \
      --primary \
      --mode "${screen1_resolution}" \
    > /dev/null 2>&1
  cleanup_but "${screen1_name}"
}

# Disable screen 1 and 3, only use screen 2
single_screen2 () {
  xrandr \
    --output "${screen2_name}" --auto \
      --primary \
      --mode "${screen2_resolution}" \
    > /dev/null 2>&1
  cleanup_but "${screen2_name}"
}

# Disable screen 1 and 2, only use screen 3
single_screen3 () {
  xrandr \
    --output "${screen3_name}" --auto \
      --primary \
      --mode "${screen3_resolution}" \
    > /dev/null 2>&1
  cleanup_but "${screen3_name}"
}

# Copy screen1 on screen2, using screen1 resolution
dual_clone () {
  xrandr \
    --output "${screen1_name}" --auto \
      --primary \
      --mode "${screen1_resolution}" \
    --output "${screen2_name}" --auto \
      --same-as "${screen1_name}" \
    > /dev/null 2>&1
  cleanup_but "${screen1_name}\|${screen2_name}"
}

# Use two independent screens
dual_split () {
  xrandr \
    --output "${screen1_name}" --auto \
      --primary \
      --mode "${screen1_resolution}" \
    --output "${screen2_name}" --auto \
      --mode "${screen2_resolution}" \
      --"${screen2_position}" "${screen1_name}" \
    > /dev/null 2>&1
  cleanup_but "${screen1_name}\|${screen2_name}"
}

# Yolo
rf () {
  xrandr \
    --output "${screen1_name}" --auto \
      --primary \
      --mode "${screen1_resolution}" \
      --pos 940x1190 \
      --rotate normal \
    --output "${screen2_name}" \
      --mode "${screen2_resolution}" \
      --pos 2377x0 \
      --rotate normal \
    --output "${screen3_name}" \
      --mode "${screen3_resolution}" \
      --pos 0x0 \
      --rotate normal \
    > /dev/null 2>&1
  cleanup_but "${screen1_name}\|${screen2_name}\|${screen3_name}"
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

################
## ACTIVATION ##
################

# Otherwise, let the user choose
case ${mode} in

  dual_clone)
    dual_clone
    reload_bars
    exit 0
    ;;

  dual_split)
    dual_split
    reload_bars
    exit 0
    ;;

  single_screen1)
    single_screen1
    reload_bars
    exit 0
    ;;

  single_screen2)
    single_screen2
    reload_bars
    exit 0
    ;;

  single_screen3)
    single_screen3
    reload_bars
    exit 0
    ;;

  rf)
    rf
    reload_bars
    exit 0
    ;;

  options)
    options
    exit 0
    ;;

  *)
    echo "ERROR: unknown mode ${mode}"
    display_help
    exit 2
    ;;
esac

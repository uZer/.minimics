#!/bin/sh
#
# Manage screens
# Type xrandr to get correct screen names

set -eu
. "${HOME}"/.minimicsrc

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

###################
## CONFIGURATION ##
###################

# Configure screens
screen1_name="${MINIMICS_SCREEN1_NAME:-eDP1}"
screen1_resolution="${MINIMICS_SCREEN1_RESOLUTION:-1366x768}"
screen2_name="${MINIMICS_SCREEN2_NAME:-HDMI2}"
screen2_resolution="${MINIMICS_SCREEN2_RESOLUTION:-1920x1080}"

# Position: left-of, right-of, above, below
screen2_position="${MINIMICS_SCREEN2_POSITION:-left-of}"

# Split or clone by default
mode=${1:-dual_split}

# Halp
display_help () {
  cat << EOF
Configure displays with xrandr.

If only one screen is connected, this script will disable other screens and
set the resolution specified in the configuration.

Otherwise, you can choose a display mode:

 single_screen1,
 single_screen2,
 dual_split,
 dual_clone

Example:

$0 dual_split
EOF
}

# Display available options for rofi applets
options () {
  single_screen1=" ;single_screen1"
  single_screen2=" ;single_screen2"
  dual_split=" ;dual_split"
  dual_clone=" ;dual_clone"
  echo "${single_screen1}\n${single_screen2}\n${dual_split}\n${dual_clone}"
}

# Reload bars
reload_bars () {
  ~/.minimics/bin/polybar.sh
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

#################
## SCREEN MODS ##
#################

# Disable screen 2, only use screen 1
single_screen1 () {
  xrandr \
    --output "${screen2_name}" --off \
    --output "${screen1_name}" --auto \
      --primary \
      --mode ${screen1_resolution} \
    > /dev/null 2>&1
}

# Disable screen 1, only use screen 2
single_screen2 () {
  xrandr \
    --output "${screen1_name}" --off \
    --output "${screen2_name}" --auto \
      --primary \
      --mode ${screen2_resolution} \
    > /dev/null 2>&1
}

# Copy screen1 on screen2, using screen1 resolution
dual_clone () {
  xrandr \
    --output "${screen1_name}" --auto \
      --primary \
      --mode ${screen1_resolution} \
    --output "${screen2_name}" --auto \
      --same-as "${screen1_name}" \
    > /dev/null 2>&1
}

# Use two independent screens
dual_split () {
  xrandr \
    --output "${screen1_name}" --auto \
      --primary \
      --mode ${screen1_resolution} \
    --output "${screen2_name}" --auto \
      --mode ${screen2_resolution} \
      --${screen2_position} "${screen1_name}" \
    > /dev/null 2>&1
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

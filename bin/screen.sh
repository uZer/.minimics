#!/bin/sh
#
# Manage screens
# Type xrandr to get correct screen names

set -eu
. "${HOME}"/.minimicsrc

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

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

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

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
  exit 0
}

# Disable screen 1, only use screen 2
single_screen2 () {
  xrandr \
    --output "${screen1_name}" --off \
    --output "${screen2_name}" --auto \
      --primary \
      --mode ${screen2_resolution} \
    > /dev/null 2>&1
  exit 0
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
  exit 0
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
  exit 0
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

################
## ACTIVATION ##
################

if [ "${mode}" = "help" ] || [ "${mode}" = "-h" ] || [ "${mode}" = "--help" ]; then
  display_help
  exit 4
fi

# Detect screens and force a mode if only one screen is connected
detect=$(xrandr)
if true \
  && echo "${detect}" | grep "${screen1_name} connected" > /dev/null 2>&1 \
  && echo "${detect}" | grep "${screen2_name} disconnected" > /dev/null 2>&1; then
  single_screen1
elif true \
  && echo "${detect}" | grep "${screen1_name} disconnected" > /dev/null 2>&1 \
  && echo "${detect}" | grep "${screen2_name} connected" > /dev/null 2>&1; then
  single_screen2
fi

# Otherwise, let the user choose
case ${mode} in

  dual_clone)
    dual_clone
    ;;

  dual_split)
    dual_split
    ;;

  single_screen1)
    single_screen1
    ;;

  single_screen2)
    single_screen2
    ;;

  *)
    echo "ERROR: unknown mode ${mode}"
    exit 2
    ;;
esac

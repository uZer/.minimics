#!/bin/sh
# rofi_screen: applet to choose screen display mode

bin="${HOME}/.minimics/bin/screen.sh"
bin_message="XRANDR CONFIGURATION"
cmd="rofi -theme ${HOME}/.minimics/rofi/screen.rasi"
available_options=$("${bin}" options)

# Open rofi and fetch result
chosen=$(echo -e "${available_options}" | cut -d ';' -f 1 | ${cmd} -p "${bin_message}" -dmenu -selected-row 0)

# Run script if choice has been made in applet
if [ "${chosen}" != "" ]; then
  "${bin}" "$(echo -e "${available_options}" | grep "${chosen}" | cut -d ';' -f 2)"
fi

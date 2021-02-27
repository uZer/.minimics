#!/bin/sh
# Also edit /usr/share/sddm/scripts/Xsetup
# Type xrandr to get correct screen names
intern=eDP-1
extern=DP-2-1
mode=split
# mode=clone
mainresolution="1920x1080"
# mainresolution="1600x900"

# DOCK #########################################################################
# 2 screens, internal + HDMI on dock
if xrandr | grep "$extern connected"; then
  if [ ""${mode} == "clone" ]; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --auto --same-as "$intern" --mode ${mainresolution}
  else
    xrandr \
      --output "$intern" --auto --mode ${mainresolution} \
      --output "$extern" --auto --above "$intern"
  fi
    # killall synergyc > /dev/null 2>&1
    # synergyc -n ovoid synergyserver.local

# JUST LAPTOP ##################################################################
else
    xrandr \
      --output "$intern" --auto --mode ${mainresolution} \
      --output "$extern" --off
    # killall synergyc > /dev/null 2>&1
fi

nitrogen --restore 2>&1 > /dev/null

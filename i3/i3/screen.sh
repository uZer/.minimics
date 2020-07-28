#!/bin/sh
# Also edit /usr/share/sddm/scripts/Xsetup
# Type xrandr to get correct screen names
intern=DVI-I-1
extern=DP-1
internresolution="1920x1080"
externresolution="1920x1080"
mode=split
# mode=clone

if xrandr | grep "$extern connected"; then
  if [ ${mode} == "clone" ]; then
    xrandr \
      --output "$intern" --auto --mode ${internresolution} \
      --output "$extern" --auto --left-of "$intern" --same-as "$intern" --mode ${internresolution}
  else
    xrandr \
      --output "$intern" --auto --mode ${internresolution} \
      --output "$extern" --auto --right-of "$intern" --mode ${externresolution}
  fi
fi
nitrogen --restore 2>&1 > /dev/null

#!/bin/sh
# Also edit /usr/share/sddm/scripts/Xsetup
# Type xrandr to get correct screen names
intern=eDP-1
extern=DP-2-1
# extern=DP-2
mode=split
# mode=clone
# mainresolution="1920x1080"
# extresolutiondouble="2880x1620+0+0" # extresolution * scale
extresolutiondouble="3072x1728+0+0" # extresolution * scale
mainresolution="3200x1800"

# DOCK #########################################################################
# 2 screens, internal + HDMI on dock
if xrandr | grep "$extern connected"; then
  if [ ""${mode} == "clone" ]; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --auto --same-as "$intern" --mode ${mainresolution}
  else
    xrandr \
      --output "$intern" --mode ${mainresolution} --pos 0x1728 \
      --output "$extern" --scale 1.6x1.6 --pos 0x0 --panning ${extresolutiondouble}
      # --output "$extern" --auto --above "$intern"
  fi
    # killall synergyc > /dev/null 2>&1
    # synergyc -n ovoid synergyserver.local

# JUST LAPTOP ##################################################################
else
    xrandr --dpi 192 \
      --output "$intern" --auto --mode ${mainresolution} \
      --output "$extern" --off
    # killall synergyc > /dev/null 2>&1
fi

nitrogen --restore 2>&1 > /dev/null

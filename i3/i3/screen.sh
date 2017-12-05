#!/bin/sh
# Also edit /usr/share/sddm/scripts/Xsetup
intern=eDP1
extern=HDMI2

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
    nitrogen --restore 2>&1 > /dev/null
    # killall synergyc
else
    xrandr --output "$intern" --auto --output "$extern" --auto --right-of "$intern"
    nitrogen --restore 2>&1 > /dev/null
    # synergyc -n ovoid synergyserver.local
fi


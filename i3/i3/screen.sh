# Also edit /usr/share/sddm/scripts/Xsetup
#!/bin/sh
intern=eDP1
extern=HDMI2
osones=DP2-2

if xrandr | grep "$extern connected"; then
    xrandr --output "$intern" --auto --output "$extern" --auto --right-of "$intern"
    nitrogen --restore 2>&1 > /dev/null
    # killall synergyc
elif xrandr | grep "$osones connected"; then
    xrandr --output "$intern" --auto --output "$osones" --auto --right-of "$intern"
    nitrogen --restore 2>&1 > /dev/null
else
    xrandr --output "$extern" --off --output "$osones" --off --output "$intern" --auto
    nitrogen --restore 2>&1 > /dev/null
    # synergyc -n ovoid synergyserver.local
fi

# Prepare lockscreen
# ./lock2.sh -u wallpaper

#!/bin/sh
# Also edit /usr/share/sddm/scripts/Xsetup
# Type xrandr to get correct screen names
intern=eDP1
extern=HDMI2
dockscreen1=DP2-1
dockscreen2=DP2-2
dockscreen3=DP2-3
# Screen position on the desk, left to right:
# HDMI: intern - extern - synergy server screen
# DOCK: dockscreen1 - dockscreen2 - dockscreen3 - intern

# HDMI #########################################################################
# 2 screens, internal + HDMI
if xrandr | grep "$extern connected"; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --auto --left-of "$intern"  \
      --output "$dockscreen1" --off \
      --output "$dockscreen2" --off \
      --output "$dockscreen3" --off
    # killall synergyc > /dev/null 2>&1
    # synergyc -n ovoid synergyserver.local

# LENOVO DOCK ##################################################################
# 2 screens, internal + DP2-1
elif xrandr | grep "$dockscreen1 connected" \
  && xrandr | grep "$dockscreen2 disconnected" \
  && xrandr | grep "$dockscreen3 disconnected"; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$dockscreen1" --auto --left-of "$intern" \
      --output "$dockscreen2" --off
      --output "$dockscreen3" --off
    # killall synergyc > /dev/null 2>&1

# 2 screens, internal + DP2-2
elif xrandr | grep "$dockscreen1 disconnected" \
  && xrandr | grep "$dockscreen2 connected" \
  && xrandr | grep "$dockscreen3 disconnected"; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$dockscreen1" --off \
      --output "$dockscreen2" --auto --left-of "$intern" \
      --output "$dockscreen3" --off
    # killall synergyc > /dev/null 2>&1

# 2 screens, internal + DP2-3
elif xrandr | grep "$dockscreen1 disconnected" \
  && xrandr | grep "$dockscreen2 disconnected" \
  && xrandr | grep "$dockscreen3 connected"; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$dockscreen1" --off \
      --output "$dockscreen2" --off \
      --output "$dockscreen3" --auto --left-of "$intern"
    # killall synergyc > /dev/null 2>&1

# 3 screens, internal + DP2-1 + DP2-2
elif xrandr | grep "$dockscreen1 connected" \
  && xrandr | grep "$dockscreen2 connected" \
  && xrandr | grep "$dockscreen3 disconnected"; then
    echo "3 screens, internal + DP2-1 + DP2-2"
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$dockscreen1" --auto --left-of "$intern" \
      --output "$dockscreen2" --auto --left-of "$dockscreen1" \
      --output "$dockscreen3" --off
    # killall synergyc > /dev/null 2>&1

# 3 screens, internal + DP2-2 + DP2-3
elif xrandr | grep "$dockscreen1 disconnected" \
  && xrandr | grep "$dockscreen2 connected" \
  && xrandr | grep "$dockscreen3 connected"; then
    echo "3 screens, internal + DP2-2 + DP2-3"
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$dockscreen1" --off \
      --output "$dockscreen2" --auto --left-of "$dockscreen3" \
      --output "$dockscreen3" --auto --left-of "$intern"
    # killall synergyc > /dev/null 2>&1

# 3 screens, internal + DP2-1 + DP2-3
elif xrandr | grep "$dockscreen1 connected" \
  && xrandr | grep "$dockscreen2 disconnected" \
  && xrandr | grep "$dockscreen3 connected"; then
    echo "3 screens, internal + DP2-1 + DP2-3"
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$dockscreen3" --auto --left-of "$intern" \
      --output "$dockscreen1" --auto --left-of "$dockscreen3" \
      --output "$dockscreen2" --off
    # killall synergyc > /dev/null 2>&1

# JUST LAPTOP ##################################################################
else
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$dockscreen1" --off \
      --output "$dockscreen2" --off \
      --output "$dockscreen3" --off
    # killall synergyc > /dev/null 2>&1
fi

nitrogen --restore 2>&1 > /dev/null

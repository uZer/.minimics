# Also edit /usr/share/sddm/scripts/Xsetup
#!/bin/sh
intern=eDP1
extern=HDMI2
osones1=DP2-1
osones2=DP2-2

if xrandr | grep "$extern connected"; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --auto --right-of "$intern" \
      --output "$osones1" --off \
      --output "$osones2" --off
elif xrandr | grep "$osones1 connected" && xrandr | grep "$osones2 disconnected"; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$osones1" --auto --left-of "$intern" \
      --output "$osones2" --off

elif xrandr | grep "$osones2 connected" && xrandr | grep "$osones1 disconnected"; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$osones1" --off \
      --output "$osones2" --auto --left-of "$intern"
elif xrandr | grep "$osones1 connected" && xrandr | grep "$osones2 connected"; then
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$osones1" --auto --left-of "$intern" \
      --output "$osones2" --auto --left-of "$osones1"
else
    xrandr \
      --output "$intern" --auto \
      --output "$extern" --off \
      --output "$osones1" --off \
      --output "$osones2" --off
fi

nitrogen --restore 2>&1 > /dev/null

# Prepare lockscreen
# ./lock2.sh -u wallpaper

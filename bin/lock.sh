#!/usr/bin/env bash
set -ex

# Generate a custom lockscreen and effectively lock the screen
# Requirements:
# - wayland: swaylock-effects
# - xorg: betterlockscreen

# default paths
logo=~/ypi.syncbox/projects/schematicwizard.avatars/favicon.png
lockscreen=~/.cache/lock.png

# backup colors (pywal overrided)
foreground=bfbfbf
color0=002629
color1=7e3a12
color2=296758
color4=13516c
color9=A84E18
color10=378A76

# import pywal colors
# shellcheck source=/dev/null
. ~/.cache/wal/colors-swaylock.sh

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

generate_lockscreen () {
  grim - | ffmpeg -i - -vf "\
    [in] gblur=sigma=5:steps=2 [blurred]; \
    [blurred] vignette=angle=PI/4 [out]" \
    "${lockscreen}"
}

generate_lockscreen_logo () {
  grim - | ffmpeg -i - -vf "\
    [in] gblur=sigma=5:steps=2 [blurred]; \
    movie=$logo, scale=330:-1 [logo]; \
    [blurred][logo] overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2 [ready]; \
    [ready] vignette=angle=PI/4 [out]" \
    "${lockscreen}"
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#
if [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
  # # cleanup
  # [ -f "${lockscreen}" ] && rm ~/.cache/lock.png &> /dev/null
  # generate_lockscreen
  swaylock \
    --daemonize \
    -S --effect-blur 5x2 --effect-vignette 0.1:1 \
    --indicator-radius 160 \
    --indicator-thickness 22 \
    --inside-color "${color0}44" \
    --inside-clear-color "${color4}44" \
    --inside-ver-color "${color2}aa" \
    --inside-wrong-color "${color1}" \
    --key-hl-color "${color1}" \
    --bs-hl-color "${color2}" \
    --ring-color "${color0}" \
    --ring-clear-color "${color4}22" \
    --ring-wrong-color "${color9}" \
    --ring-ver-color "${color2}" \
    --line-uses-inside \
    --font 'NotoSans Nerd Font Mono:style=Thin,Regular 40' \
    --text-color "${foreground}" \
    --text-clear-color "${color4}" \
    --text-wrong-color "${color9}" \
    --text-ver-color "${color10}" \
    --separator-color 00000000
  #   --image "${lockscreen}" \
else
  betterlockscreen -l dim --text "$(hostname -s) is locked"
fi

#!/usr/bin/env bash
#
# Generate a custom lockscreen and effectively lock the screen
# Requirements:
# - wayland: swaylock-effects
# - xorg: betterlockscreen

set -eux

# backup colors (pywal overrided)
foreground=bfbfbf color0=002629 color1=7e3a12 color2=296758 color4=13516c
color9=A84E18 color10=378A76 color12=1A6C91

# import pywal colors
# shellcheck source=/dev/null
. ~/.cache/wal/colors-swaylock.sh

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

########################################
## Tools to generate a custom picture ##
########################################

lockscreen=~/.cache/lock.png
logo=~/ypi.syncbox/projects/schematicwizard.avatars/favicon.png

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

# different themes with swaylock
lock_wayland () {
  case "${1}" in
    native)
      # native blur and vignette
      params="-S --effect-blur 5x2 --effect-vignette 0.2:1"
      ;;

    privacy)
      # only use pywal background and add intense blur + vignette
      params="--image $(cat ~/.cache/wal/wal) --effect-blur 25x3 --effect-vignette 0:1"
      ;;

    *)
      # use ffmpeg to generate the lockscreen
      # cleanup
      [ -f "${lockscreen}" ] && rm ~/.cache/lock.png &> /dev/null
      generate_lockscreen
      params="--image ${lockscreen}"
  esac

  # shellcheck disable=2086
  swaylock \
    --daemonize \
    $params \
    --indicator-radius 160 \
    --indicator-thickness 22 \
    --inside-color "${color0}44" \
    --inside-clear-color "${color4}aa" \
    --inside-ver-color "${color2}aa" \
    --inside-wrong-color "${color1}aa" \
    --key-hl-color "${color1}" \
    --bs-hl-color "${color2}" \
    --ring-color "${color0}" \
    --ring-clear-color "${color4}" \
    --ring-wrong-color "${color9}" \
    --ring-ver-color "${color2}" \
    --line-uses-inside \
    --font 'NotoSans Nerd Font Mono:style=Thin,Regular 40' \
    --text-color "${foreground}" \
    --text-clear-color "${color12}" \
    --text-wrong-color "${color9}" \
    --text-ver-color "${color10}" \
    --separator-color 00000000
}

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

if [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
  lock_wayland "${1:-privacy}"
else
  betterlockscreen -l dim --text "$(hostname -s) is locked"
fi

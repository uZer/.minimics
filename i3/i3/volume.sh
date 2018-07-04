#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
  amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
  volume=`get_volume`
  bar="$(seq -s "█" 0 $(($volume / 10)) | sed 's/[0-9]//g')"
  dunstify -i notification-audio-volume-high -r 2593 -a Volume "$volume   $bar"
}

case $1 in
  up)
    # amixer -D pulse set Master on > /dev/null
    # amixer -D pulse sset Master 5%+ > /dev/null
    pactl set-sink-volume 0 +5%
    send_notification
    ;;
  down)
    # amixer -D pulse set Master on > /dev/null
    # amixer -D pulse sset Master 5%- > /dev/null
    pactl set-sink-volume 0 -5%
    send_notification
    ;;
  mute)
    # amixer -D pulse set Master 1+ toggle > /dev/null
    pactl set-sink-mute 0 toggle
    if is_mute ; then
      dunstify -i notification-audio-volume-muted -r 2593 -a Volume-mute "mute  "
    else
      send_notification
    fi
    ;;
esac

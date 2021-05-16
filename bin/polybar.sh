#!/usr/bin/env bash

. "${HOME}"/.minimicsrc

dir="$HOME/.config/polybar"

launch_bars() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

  # Detect connected screens
  outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)

	# Launch the bar on each screen
  for screen in $outputs; do
	  MONITOR=$screen polybar -q main -r -c "$dir/advancedblocks/config.ini" &
  done

  # Only launch tray on primary screen
	polybar -q main -r -c "$dir/advancedblocks/tray.ini" &
}

launch_bars

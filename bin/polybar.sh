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
	  MONITOR=$screen polybar -q main -c "$dir/advancedblocks/config.ini" &
  done
}

launch_bars

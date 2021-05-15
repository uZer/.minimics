#!/usr/bin/env bash

. "${HOME}"/.minimicsrc

dir="$HOME/.config/polybar"

launch_bars() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	polybar -q main -c "$dir/advancedblocks/config.ini" &
	polybar -q main -c "$dir/advancedblocks/tray.ini" &
}

launch_bars

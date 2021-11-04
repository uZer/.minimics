#!/usr/bin/env bash

# Author : Pavan Jadhaw
# Github Profile : https://github.com/pavanjadhaw
# Project Repository : https://github.com/pavanjadhaw/betterlockscreen

# find your resolution so images can be resized to match your screen resolution
res=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
default_timeout="$(cut -d ' ' -f4 <<< "$(xset q | sed -n '25p')")"
default_dpms=$(xset q | awk '/^[[:blank:]]*DPMS is/ {print $(NF)}')

init_filenames() {
	#$1 resolution

	# copy this block to ~/.config/betterlockscreenrc" to customize
	insidecolor=00000000
	ringcolor=ffffffff
	keyhlcolor=d23c3dff
	bshlcolor=d23c3dff
	separatorcolor=00000000
	insidevercolor=00000000
	insidewrongcolor=d23c3dff
	ringvercolor=ffffffff
	ringwrongcolor=ffffffff
	verifcolor=ffffffff
	timecolor=ffffffff
	datecolor=ffffffff
	loginbox=00000066
	font="sans-serif"
	locktext='Type password to unlock...'
	wallpaper_cmd='feh --bg-fill --no-fehbg'
	time_format='%H:%M:%S'

	# override defaults with config
	theme_rc="$HOME/.config/betterlockscreenrc"
	if [ -e "$theme_rc" ]; then
		# shellcheck disable=SC1090
		source "$theme_rc"
	fi

	# create folder in ~/.cache/i3lock directory
	res_folder="$HOME/.cache/i3lock/$1"
	folder="$HOME/.cache/i3lock/current"
	echo "Got" "$@" "$res_folder"
	if [ ! -d "$folder" ] || [ -n "$2" ]; then
		rm -rf "$folder"
		mkdir -p "$res_folder"
		ln -s "$res_folder" "$folder"
	fi

	# ratio for rectangle to be drawn for time background on lockscreen
	# Original Image
	orig_wall="$folder/wall.png"

	# Versions (from here)
	# You can use these images to set different versions as wallpaper
	# lockscreen background.
	resized="$folder/resized.png" # resized image for your resolution

	# images to be used as wallpaper
	dim="$folder/dim.png" # image with subtle overlay of black
	blur="$folder/blur.png" # blurred version
	dimblur="$folder/dimblur.png"
	pixel="$folder/pixel.png" # pixelated image

	# lockscreen images (images to be used as lockscreen background)
	l_resized="$folder/l_resized.png"
	l_dim="$folder/l_dim.png"
	l_blur="$folder/l_blur.png"
	l_dimblur="$folder/l_dimblur.png"
	l_pixel="$folder/l_pixel.png"
}

init_filenames "$res"


prelock() {
	if [ -n "$lock_timeout" ]; then
		xset dpms "$lock_timeout"
	fi
	if [ -n "$(pidof dunst)" ]; then
		pkill -u "$USER" -USR1 dunst
	fi
}


lock() {
	#$1 image path

	i3lock \
		-c 00000000 \
		-t -i "$1" \
		# --timepos='x+110:h-70' \
		# --datepos='x+43:h-45' \
		# --clock --date-align 1 --datestr "$locktext" --timestr "$time_format" \
		--insidecolor=$insidecolor --ringcolor=$ringcolor --line-uses-inside \
		--keyhlcolor=$keyhlcolor --bshlcolor=$bshlcolor --separatorcolor=$separatorcolor \
		--insidevercolor=$insidevercolor --insidewrongcolor=$insidewrongcolor \
		--ringvercolor=$ringvercolor --ringwrongcolor=$ringwrongcolor --indpos='x+280:h-70' \
		--radius=20 --ring-width=4 --veriftext='' --wrongtext='' \
		--verifcolor="$verifcolor" --timecolor="$timecolor" --datecolor="$datecolor" \
		--time-font="$font" --date-font="$font" --layout-font="$font" --verif-font="$font" --wrong-font="$font" \
		--noinputtext='' --force-clock --pass-media-keys "$lockargs"

}


postlock() {
	if [ -n "$lock_timeout" ]; then
		xset dpms "$default_timeout"
		if [ "$default_dpms" = "Disabled" ]; then
			xset -dpms
		fi
	fi
	if [ -n "$(pidof dunst)" ] ; then
		pkill -u "$USER" -USR2 dunst
	fi
}


rec_get_random() {
	dir="$1"
	if [ ! -d "$dir" ]; then
		user_input="$dir"
		return
	fi
	dirs=("$dir"*)
	random_dir="${dirs[RANDOM % ${#dirs[@]}]}"
	rec_get_random "$random_dir"
	exit 1
}


lockselect() {
	prelock
	case "$1" in
		dim)
			# lockscreen with dimmed background
			lock "$l_dim"
			;;

		blur)
			# set lockscreen with blurred background
			lock "$l_blur"
			;;

		dimblur)
			# set lockscreen with dimmed + blurred background
			lock "$l_dimblur"
			;;

		pixel)
			# set lockscreen with pixelated background
			lock "$l_pixel"
			;;

		*)
			# default lockscreen
			lock "$l_resized"
			;;
	esac
	postlock
}

# $1: number of pixels to convert
# $2: 1 for width. 2 for height
logical_px() {
	# get dpi value from xrdb
	local DPI
	DPI=$(grep -oP 'Xft.dpi:\s*\K\d+' ~/.Xresources | bc)
	if [ -n "$DPI" ]; then
		DPI=$(xdpyinfo | sed -En "s/\s*resolution:\s*([0-9]*)x([0-9]*)\s.*/\\$2/p" | head -n1)
	fi

	# return the default value if no DPI is set
	if [ -z "$DPI" ]; then
		echo "$1"
	else
		local SCALE
		SCALE=$(echo "scale=2; $DPI / 96.0" | bc)

		# check if scaling the value is worthy
		if [ "$(echo "$SCALE > 1.25" | bc -l)" -eq 0 ]; then
			echo "$1"
		else
			echo "$SCALE * $1 / 1" | bc
		fi
	fi
}

update() {
	# use
	background="$1"

	# default blur level; fallback to 1
	[[ $blur_level ]] || blur_level=1

	rectangles=" "
	SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
	for RES in $SR; do
		SRA=("${RES//[x+]/ }")
		CX=$((SRA[2] + $(logical_px 25 1)))
		CY=$((SRA[1] - $(logical_px 30 2)))
		rectangles+="rectangle $CX,$CY $((CX+$(logical_px 300 1))),$((CY-$(logical_px 80 2))) "
	done

	# User supplied Image
	user_image="$folder/user_image.png"

	# create folder
	if [ ! -d "$folder" ]; then
		echo "Creating '$folder' directory to cache processed images."
		mkdir -p "$folder"
	fi

	# get random file in dir if passed argument is a dir
	rec_get_random "$background"

	# get user image
	cp "$user_input" "$user_image"
	if [ ! -f "$user_image" ]; then
		echo 'Please specify the path to the image you would like to use'
		exit 1
	fi

	# replace orignal with user image
	cp "$user_image" "$orig_wall"
	rm "$user_image"

	echo 'Generating alternate images based on the image you specified,'
	echo 'please wait this might take few seconds...'

	# wallpapers

	echo
	echo 'Converting provided image to match your resolution...'
	# resize image
	convert "$orig_wall" -resize "$res""^" -gravity center -extent "$res" "$resized"

	echo
	echo 'Applying dim, blur, and pixelation effect to resized image'
	# dim
	convert "$resized" -fill black -colorize 40% "$dim"

	# pixel
	convert -scale 10% -scale 1000% "$resized" "$pixel"

	# blur
	blur_shrink=$(echo "scale=2; 20 / $blur_level" | bc)
	blur_sigma=$(echo "scale=2; 0.6 * $blur_level" | bc)
	convert "$resized" \
		-filter Gaussian \
		-resize "$blur_shrink%" \
		-define "filter:sigma=$blur_sigma" \
		-resize "$res^" -gravity center -extent "$res" \
		"$blur"

	# dimblur
	convert "$dim" \
		-filter Gaussian \
		-resize "$blur_shrink%" \
		-define "filter:sigma=$blur_sigma" \
		-resize "$res^" -gravity center -extent "$res" \
		"$dimblur"

	# lockscreen backgrounds

	echo
	echo 'Caching images for faster screen locking'
	# resized
	convert "$resized" -draw "fill #$loginbox $rectangles" "$l_resized"

	# dim
	convert "$dim" -draw "fill #$loginbox $rectangles" "$l_dim"

	# blur
	convert "$blur" -draw "fill #$loginbox $rectangles" "$l_blur"

	# dimblur
	convert "$dimblur" -draw "fill #$loginbox $rectangles" "$l_dimblur"

	# pixel
	convert "$pixel" -draw "fill #$loginbox $rectangles" "$l_pixel"
	echo
	echo 'All required changes have been applied'
}


wallpaper() {
	case "$1" in
		'')
			# set resized image as wallpaper if no argument is supplied by user
			wallpaper="$resized"
			;;

		dim)
			# set dimmed image as wallpaper
			wallpaper="$dim"
			;;

		blur)
			# set blurred image as wallpaper
			wallpaper="$blur"
			;;

		dimblur)
			# set dimmed + blurred image as wallpaper
			wallpaper="$dimblur"
			;;

		pixel)
			# set pixelated image as wallpaper
			wallpaper="$pixel"
			;;
	esac
	eval "$wallpaper_cmd $wallpaper"
}


empty() {
	if [ -f "$l_dim" ]; then
		echo -e "\nSeems you haven't provided any arguments. See below for usage details."
	else
		echo 'Important: Update the image cache (e.g. $0 -u path/to/image.jpg).'
		echo
		echo '		Image cache must be updated to initially configure or update the wallpaper used.'
	fi

	echo
	echo 'For other sets of options and help, use the help command.'
	echo 'e.g. $0 -h or $0 --help'
	exit 1
}


usage() {
  cat << EOF
Important: Update the image cache (e.g. $0 -u path/to/image.jpg).
Image cache must be updated to initially configure or update wallpaper used

Options:

	-h --help
		For help (e.g. $0 -h or $0 --help).

	-u --update
		to update image cache, you should do this before using any other options
		E.g: $0 -u path/to/image.png when image.png is custom background
		Or you can use $0 -u path/to/imagedir and a random file will be selected.

	-l --lock
		to lock screen (e.g. $0 -l)
		you can also use dimmed or blurred background for lockscreen.
		E.g: $0 -l dim (for dimmed background)
		E.g: $0 -l blur (for blurred background)
		E.g: $0 -l dimblur (for dimmed + blurred background)

	-s --suspend
		to suspend system and lock screen (e.g. $0 -s)
		you can also use dimmed or blurred background for lockscreen.
		E.g: $0 -s dim (for dimmed background)
		E.g: $0 -s blur (for blurred background)
		E.g: $0 -s dimblur (for dimmed + blurred background)

	-w --wall
		you can also set lockscreen background as wallpaper
		to set wallpaper (e.g. $0 -w or $0 --wall)
		(The default wallpaper setter is feh, to set your own use the -wc command)
		you can also use dimmed or blurred variants.
		E.g: $0 -w dim (for dimmed wallpaper)
		E.g: $0 -w blur (for blurred wallpaper)
		E.g: $0 -w dimblur (for dimmed + blurred wallpaper)

	-r --resolution
		to be used after -u
		used to set a custom resolution for the image cache.
		E.g: $0 -u path/to/image.png -r 1920x1080
		E.g: $0 -u path/to/image.png --resolution 3840x1080

	-b --blur
		to be used after -u
		used to set blur intensity. Default to 1.
		E.g: $0 -u path/to/image.png -b 3
		E.g: $0 -u path/to/image.png --blur 0.5

	-t --text
		to set custom lockscreen text (max 31 chars)
 		E.g: $0 -l dim -t \"Dont touch my machine!\""
		E.g: $0 --text "Hi, user!" -s blur

	--off <timeout>
		to set custom monitor turn off timeout for lockscreen
		timeout is in seconds
		E.g: $0 -l dim --off 5

	-wc --wallpaper_cmd <command>
		to set your custom wallpaper setter
		the default is "feh --bg-fill --no-fehbg"
		E.g: $0 -wc "xwallpaper --zoom" -w

	-tf --time_format <format>
		to set the time format used by i3lock-color
		see the i3lock or strftime man pages for more details.
		E.g: $0 -l dim -tf "%I:%M %p"
EOF
}


# Options
[[ "$1" = '' ]] && empty

for arg in "$@"; do
	[[ "${arg:0:1}" = '-' ]] || continue

	case "$1" in
		-h | --help)
			usage
			break
			;;

		-s | --suspend)
			runsuspend=true
			;&

		-l | --lock)
			runlock=true
			[[ $runsuspend ]] || lockargs="$lockargs -n"
			if [[ ${2:0:1} = '-' ]]; then
				shift 1
			else
				lockstyle="$2"; shift 2
			fi
			;;

		-w | --wall | --wallpaper)
			wallpaper "$2"
			shift 2
			;;

		-u | --update)
			runupdate=true
			imagepath="$2"
			shift 2
			;;

		-t | --text)
			locktext="$2"
			shift 2
			;;

		--off)
			lock_timeout="$2"
			shift 2
			;;

		-r | --resolution)
			res="$2"
			init_filenames "$res" force
			shift 2
			;;

		-b | --blur)
			blur_level="$2"
			shift 2
			;;

		-wc | --wallpaper_cmd)
			wallpaper_cmd="$2"
			shift 2
			;;

		-tf | --time_format)
			time_format="$2"
			shift 2
			;;

		--)
			lockargs="$lockargs ${*:2}"
			break
			;;

		*)
			echo "invalid argument: $1"
			break
			;;
	esac
done

# Run image generation
[[ $runupdate ]] && update "$imagepath"

# Activate lockscreen
[[ $runlock ]] && lockselect "$lockstyle" && \
	{ [[ $runsuspend ]] && systemctl suspend; }

exit 0

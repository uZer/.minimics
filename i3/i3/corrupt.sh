#!/usr/bin/env bash
#
# Requirements:
# - scrot
# - corrupter https://github.com/r00tman/corrupter
# - i3lock
#
tmpbg="/tmp/screen.png"

scrot "$tmpbg"
corrupter \
  -add 0 \
  -bheight 100 \
  -boffset 200 \
  -lag 0.001 \
  -lb 100 \
  -lg 50 \
  -lr 80 \
  -mag 2 \
  "$tmpbg" "$tmpbg"
  # -meanabber 20 \
  # -stdabber 5 \
  # -stdoffset 4 \
  # -stride 0.01 \

# ICON="$SCRIPTPATH/OSONES_PICTO.png"
# HUE=(-level 0%,100%,0.9 -separate -average)
# LOCK=(-font $FONT -pointsize 14 -fill white \
#        -annotate +$MIDXt+$MIDYt "$TEXT" \
#        -fill lightgrey -annotate +$MIDXt+$MIDYt "$TEXT" \
#        $ICON -geometry +$MIDXi+$MIDYi -composite)
# convert "$tmpbg" "${HUE[@]}" "${LOCK[@]}" "$tmpbg"

i3lock -i "$tmpbg" \
  --insidecolor=ffffff1c \
  --ringcolor=ffffff3e \
  --linecolor=ffffff00 \
  --keyhlcolor=00000080 \
  --ringvercolor=00000000 \
  --separatorcolor=22222260 \
  --insidevercolor=0000001c \
  --ringwrongcolor=00000055 \
  --insidewrongcolor=0000001c \
  --datecolor=ffffffff \
  --timecolor=ffffffff \
  --timepos='w/2:h/2-140' \
  --datepos='w/2:h/2-115' \
  --datestr="%A %d/%m/%Y" \
  --wrongtext="" \
  --noinputtext="" \
  --veriftext=""
  # --clock \

rm "$tmpbg"

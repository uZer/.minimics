#!/bin/bash
IMG=~/.lockbg.png
if [ $# -eq 0 ];
then MSG="AFK"
else MSG="$1"
fi
FONT='PragmataPro-For-Powerline'

BLURTYPE="2x8"
TEXTCOLOR=ffffff00
INSIDECOLOR=ffffff1c
RINGCOLOR=ffffff3e
LINECOLOR=ffffff00
KEYHLCOLOR=00000080
RINGVERCOLOR=00000000
INSIDEVERCOLOR=0000001c
RINGWRONGCOLOR=00000055
INSIDEWRONGCOLOR=0000001c
MSGCOLOR='#ffffff'

xset s noblank ; xset s off ; xset -dpms

scrot $IMG
convert $IMG \
    -level 0%,100%,0.6 -blur $BLURTYPE -font $FONT -pointsize 36 \
    -fill $MSGCOLOR -gravity center -annotate +300-400 "${MSG}" $IMG

i3lock \
    --textcolor=$TEXTCOLOR \
    --insidecolor=$INSIDECOLOR \
    --ringcolor=$RINGCOLOR \
    --linecolor=$LINECOLOR \
    --keyhlcolor=$KEYHLCOLOR \
    --ringvercolor=$RINGVERCOLOR \
    --insidevercolor=$INSIDEVERCOLOR \
    --ringwrongcolor=$RINGWRONGCOLOR -i $IMG
rm $IMG

#!/usr/bin/env bash
# Author: Dolores Portalatin <hello@doloresportalatin.info>
# Dependencies: imagemagick, i3lock-color-git, scrot
set -o errexit -o noclobber -o nounset

HUE=(-level 0%,100%,0.6)
EFFECT=(-filter Gaussian -resize 20% -define filter:sigma=1.5 -resize 500.5%)
# default system sans-serif font
FONT="$(convert -list font | awk "{ a[NR] = \$2 } /family: $(fc-match sans -f "%{family}\n")/ { print a[NR-1]; exit }")"
IMAGE="$(mktemp).png"

OPTIONS="Options:
    -h, --help   This help menu.
    -g, --greyscale  Set background to greyscale instead of color.
    -p, --pixelate   Pixelate the background instead of blur, runs faster.
    -f <fontname>, --font <fontname>  Set a custom font. Type 'convert -list font' in a terminal to get a list."

# move pipefail down as for some reason "convert -list font" returns 1
set -o pipefail
trap 'rm -f "$IMAGE"' EXIT
TEMP="$(getopt -o :hpgf: -l help,pixelate,greyscale,font: --name "$0" -- "$@")"
eval set -- "$TEMP"

while true ; do
    case "$1" in
        -h|--help)
            printf "Usage: $(basename $0) [options]\n\n$OPTIONS\n\n" ; exit 1 ;;
        -g|--greyscale) HUE=(-level 0%,100%,0.6 -set colorspace Gray -separate -average) ; shift ;;
        -p|--pixelate) EFFECT=(-scale 1% -scale 10000%) ; shift ;;
        -f|--font)
            case "$2" in
                "") shift 2 ;;
                *) FONT=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "error" ; exit 1 ;;
    esac
done

SCRIPTPATH="$HOME/.i3/"

# l10n support
TEXT="Type password to unlock"
case "$LANG" in
    de_* ) TEXT="Bitte Passwort eingeben" ;; # Deutsch
    en_* ) TEXT="Cast a spell to unlock" ;; # English
    es_* ) TEXT="Ingrese su contraseña" ;; # Española
    fr_* ) TEXT="Entrez votre mot de passe" ;; # Français
    pl_* ) TEXT="Podaj hasło" ;; # Polish
esac

scrot -z "$IMAGE"
ICON="$SCRIPTPATH/OSONES_PICTO.png"
PARAM=(--insidecolor=ffffff1c --ringcolor=ffffff3e \
       --linecolor=ffffff00 --keyhlcolor=00000080 --ringvercolor=00000000 \
       --separatorcolor=22222260 --insidevercolor=0000001c \
       --ringwrongcolor=00000055 --insidewrongcolor=0000001c \
       --datecolor=ffffffff --timecolor=ffffffff
       --timepos='w/2:h/2-140' --datepos='w/2:h/2-115' --clock \
       --datestr="%A %d/%m/%Y" --wrongtext="" --noinputtext="" --veriftext=""
       )

LOCK=()
while read LINE
do
    if [[ "$LINE" =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
        W=${BASH_REMATCH[1]}
        H=${BASH_REMATCH[2]}
        Xoff=${BASH_REMATCH[3]}
        Yoff=${BASH_REMATCH[4]}
        MIDXi=$(($W / 2 + $Xoff - 200  / 2))
        MIDYi=$(($H / 2 + $Yoff - 200  / 2))
        MIDXt=$(($W / 2 + $Xoff - 185 / 2))
        MIDYt=$(($H / 2 + $Yoff + 250 / 2))
        LOCK+=(-font $FONT -pointsize 14 -fill white \
               -annotate +$MIDXt+$MIDYt "$TEXT" \
               -fill lightgrey -annotate +$MIDXt+$MIDYt "$TEXT" \
               $ICON -geometry +$MIDXi+$MIDYi -composite)
    fi
done <<<"$(xrandr)"

convert "$IMAGE" "${HUE[@]}" "${EFFECT[@]}" "${LOCK[@]}" "$IMAGE"

# try to use a forked version of i3lock with prepared parameters
if ! i3lock -n "${PARAM[@]}" -i "$IMAGE" > /dev/null 2>&1; then
    # We have failed, lets get back to stock one
    i3lock -n -i "$IMAGE"
fi

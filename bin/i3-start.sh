#!/bin/sh

set -u

killall picom 2>/dev/null
"${HOME}/.minimics/bin/pywal.sh" -f -e -q -s -t
"${HOME}/.minimics/bin/pywal.sh" "${HOME}/.minimics/pywal16/colorschemes/dark/sw16-sixteal-soft-darker.json" -q
picom -b --config ~/.minimics/picom/picom.conf
"${HOME}/.minimics/bin/polybar.sh"

# "${HOME}/.minimics/bin/lock_update.sh"

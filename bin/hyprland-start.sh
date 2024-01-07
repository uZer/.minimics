#!/bin/sh
set -u
"${HOME}/.minimics/bin/pywal.sh" -f -e -q -s -t
"${HOME}/.minimics/bin/pywal.sh" "${HOME}/.minimics/pywal16/colorschemes/dark/sw16-sixteal-soft-darkest.json" -q
/usr/lib/polkit-kde-authentication-agent-1 &
nm-applet &

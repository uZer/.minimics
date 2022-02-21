#!/bin/sh
#
# Generate lockscreen

. "${HOME}"/.minimicsrc

betterlockscreen \
  -u "${MINIMICS_WALLS}" \
  --span

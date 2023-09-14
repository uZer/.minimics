#!/bin/sh
#
# Generate lockscreen

# shellcheck source=../minimicsrc.dist
. "${HOME}"/.minimicsrc

betterlockscreen \
  -u "${MINIMICS_WALLS}" \
  --span

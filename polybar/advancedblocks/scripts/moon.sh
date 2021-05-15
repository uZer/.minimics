#!/bin/sh

# Import configuration
if [ -f ~/.minimicsrc ]; then
  source ~/.minimicsrc
fi

# Compute
moon=$(curl -sS "https://wttr.in/${MINIMICS_CITY:Paris}?format=%m" 2> /dev/null)

# Display
echo "${moon}"

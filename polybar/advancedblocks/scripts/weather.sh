#!/bin/sh

param=$1

# Import configuration
if [ -f ~/.minimicsrc ]; then
  source ~/.minimicsrc
fi

if [ "$param" = "moon" ]; then
  out=$(curl -sS "https://wttr.in/${MINIMICS_CITY:Paris}?format=%m" 2> /dev/null)
else
  out=$(curl -sf "https://wttr.in/${MINIMICS_CITY:Paris}?0pq&lang=fr&format=1" 2> /dev/null | sed 's/+/ /g' | sed 's/:/ /g')
fi

# Display
echo "${out}"

#!/bin/sh
# Wrapper to launch pywal

extra=
if [ "$1" == "restore" ]; then
  extra='-R'
fi
wal -q -i ~/ypi.dropbox/audiovisual/__resources/walls $extra ; pywal-discord

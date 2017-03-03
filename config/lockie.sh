#!/usr/bin/env sh
FILE="/tmp/.lockie.png"

scrot $FILE
notify-send "Locking screen"
# Accurate, slower
# convert $FILE -blur 6x3 $FILE
# Less accurate, twice as fast
convert $FILE -scale 50% -blur 3x3 -scale 200% $FILE

i3lock -i $FILE

#!/usr/bin/env sh
FILE="/tmp/.lockie.png"

notify-send "Locking screen"
scrot $FILE
convert $FILE -blur 6x3 $FILE
i3lock -i $FILE

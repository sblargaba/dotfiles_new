#!/bin/sh

xrdb ~/.Xresources

setxkbmap gb
# start some nice programs
exec awesome

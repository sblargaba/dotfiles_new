#!/bin/sh
#setxkbmap us -variant altgr-intl
#[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xrdb ~/.Xresources &
#numlockx &
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh) &
#export SSH_AUTH_SOCK &
# start some nice programs
exec awesome
#exec bspwm

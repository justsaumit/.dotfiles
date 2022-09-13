#!/bin/sh

dunst &
sxhkd &
setbg &
nm-applet &
unclutter &
picom --experimental-backends &
setxkbmap -option caps:escape &
dwmblocks &
exec dwm

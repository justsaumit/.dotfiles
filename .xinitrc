#!/bin/sh

dunst &
sxhkd &
setbg &
unclutter &
picom &
setxkbmap -option caps:escape &
dwmblocks &
exec dwm

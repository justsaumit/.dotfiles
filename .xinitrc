#!/bin/sh

dunst &
sxhkd &
setbg &
nm-applet &
unclutter &
picom --experimental-backends &
xmodmap ~/.config/xmodmap
setxkbmap -option caps:escape &
dwmblocks &
exec dwm 

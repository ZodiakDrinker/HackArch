#!/bin/sh
xrandr --auto
sxhkd &
picom -b &
exec bspwm

#!/bin/bash

# This script triggers the lock screen with blurred screenshot as image.
# 
# It overlays the screenshot with an lock icon in the center of each monitor.
# Currently it's supposing the monitors are arranged from the left to the right in the
# same order they appear in the output of `xrandr`.
# Only horizontally arranged monitors are supported.

lock="$HOME/.cache/i3lock_lock"
icon="$HOME/.config/i3lock/icon.png"
image="$HOME/.cache/i3lock_background.png"

# Create a lock
exec 200>$lock
flock -n 200 || exit 1

# Take a screenshot
scrot $image

# Pixelate the image (is much faster than using blur)
convert $image -scale 10% -scale 1000% $image
#convert $image -filter Gaussian -blur 0x8 $image

# Get the resolutions of all monitors
res=`xrandr | grep \* |awk '{print $1}' | awk -F'[x]' '{print $1, $2}'`
res=($(echo $res | tr " " "\n"))
# Get the number of values (2 values for each monitor)
n=${#res[@]}

o=16    # icon-width / 2
i=0     # iteration
lx=0    # last x offset

while [ "$i" -lt "$n" ]
do
    # Get the horizontal resolution
    x=${res[i]}
    i=$((i+1))
    # Get the vertical resolution
    y=${res[i]}
    i=$((i+1))
    # Get the icon position of the monitor
    px=$((lx+(x/2)-o))
    py=$(((y/2)-o))
    # Increase the horizontal offset for the next monitor
    lx=$((lx+x))
    # Overlay the image with an icon
    convert $image $icon -geometry +$px+$py -composite $image
done

# Display the lock screen
i3lock -u -i $image

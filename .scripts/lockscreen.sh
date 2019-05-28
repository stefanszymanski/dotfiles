#!/bin/sh

icon="$HOME/.config/i3lock/icon.png"
image="$HOME/.cache/i3lock_background.png"

# Take a screenshot
scrot $image

# Pixelate the image
convert $image -scale 10% -scale 1000% $image
# Overlay the image with a lock icon
convert $image $icon -gravity center -composite $image

i3lock -u -i $image

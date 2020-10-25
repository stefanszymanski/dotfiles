[ -r ~/.profile ] && . ~/.profile
[ -r ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
fi

pulseaudio --start
start-pulseaudio-x11
autolock &
unclutter -idle 3 &

pkill --signal KILL -x redshift
redshift -x
redshift &

sleep 1

# load host specific configuration
HOST_XINIT="$HOME/.config/x11/xinit.$(hostname)"
if [ -e "$HOST_XINIT" ] ; then
    . "$HOST_XINIT"
fi

wm="${WM:-bspwm}"

if [ -n "$DBUS_ENABLE" ]; then
    exec dbus-launch --sh-syntax --exit-with-session "$wm"
else
    exec "$wm"
fi


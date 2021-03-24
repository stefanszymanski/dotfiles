[ -r ~/.profile ] && . ~/.profile
[ -r ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
fi

# load host specific configuration
HOST_XINIT="$HOME/.config/x11/xinit.$(hostname)"
if [ -e "$HOST_XINIT" ] ; then
    . "$HOST_XINIT"
fi

if [ -n "$DBUS_ENABLE" ]; then
    exec dbus-run-session -- runsvdir -P ~/service.x
else
    exec runsvdir -P ~/service.x
fi

[ -r ~/.profile ] && . ~/.profile
[ -r ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
fi

wm="${WM:-bspwm}"

if [ -n "$DBUS_ENABLE" ]; then
    exec dbus-launch --sh-syntax --exit-with-session "$wm"
else
    exec "$wm"
fi


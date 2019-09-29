[ -r ~/.profile ] && . ~/.profile
[ -r ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

exec $STARTUP ${1:-awesome}

#exec ck-launch-session dbus-launch --sh-syntax --exit-with-x11 awesome

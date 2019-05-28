#!/bin/sh

exec xautolock \
    -detectsleep \
    -time 3 \
    -locker "$HOME/.scripts/lockscreen.sh" \
    -notify 30 \
    -notifier "notify-send -u critical -t 10000 -- 'Locking the screen in 30 seconds'"

#!/bin/bash

while true
do
    activ_win_id=`xprop -root _NET_ACTIVE_WINDOW`
    xprop -id ${activ_win_id:40:9} | grep _NET_WM_STATE_FULLSCREEN && xautolock -disable; xautolock -enable
    echo ${activ_win_id}
    sleep 30
done

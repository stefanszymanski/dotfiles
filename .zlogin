start_wm() {
    clear
    if [[ ! -d ~/.log ]]; then
        mkdir ~/.log
    fi
    logfile="$HOME/.log/xsession_$(date +%s).log"
    WM="$1" DBUS_ENABLE="$2" exec startx 1> "$logfile" 2>&1
    exit
}

if [[ -z $DISPLAY ]] && [[ -z $TMUX ]] && (( $EUID != 0 )) {
    while true; do

        clear
        cat << EOF
Please select:

1. bspwm
2. bspwm (with dbus)
3. tmux
4. continue with zsh
5. bash
0. quit
EOF

        read -sk1 "?Enter selection [0-5] > "

        if [[ $REPLY =~ ^[0-5]$ ]]; then
            echo $REPLY
            case $REPLY in
                1) start_wm bspwm ;;
                2) start_wm bspwm 1 ;;
                3) exec tmux ;;
                4) clear; break ;;
                5) clear; exec bash ;;
                0) exit ;;
            esac
        fi

    done
}

start_wm() {
    if [[ ! -d ~/.log ]]; then
        mkdir ~/.log
    fi
    clear
    WM="$1" exec startx 1> ~/.log/xsession.log 2>&1
    exit
}

if [[ -z $DISPLAY ]] && [[ -z $TMUX ]] && (( $EUID != 0 )) {
    while true; do

        clear
        cat << EOF
Please select:

1. awesomewm
2. bspwm
3. tmux
4. continue with zsh
5. bash
0. quit
EOF

        read -sk1 "?Enter selection [0-4] > "

        if [[ $REPLY =~ ^[0-4]$ ]]; then
            echo $REPLY
            case $REPLY in
                1) start_wm "awesome" ;;
                2) start_wm "bspwm" ;;
                3) exec tmux ;;
                4) clear; break ;;
                5) clear; exec bash ;;
                0) exit ;;
            esac
        fi

    done
}

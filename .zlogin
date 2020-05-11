if [[ -z $DISPLAY ]] && [[ -z $TMUX ]] && (( $EUID != 0 )) {
    while true; do

        clear
        cat << EOF
Please select:

1. X
2. Tmux 
3. Continue with zsh
4. Bash
0. Quit
EOF

        read -sk1 "?Enter selection [0-4] > "

        if [[ $REPLY =~ ^[0-4]$ ]]; then
            echo $REPLY
            case $REPLY in
                1) 
                    if [[ ! -d ~/.log ]]; then
                        mkdir ~/.log
                    fi
                    clear
                    exec startx 1> ~/.log/xsession.log 2>&1
                    exit
                    ;;
                2) 
                    exec tmux 
                    ;;
                3) 
                    clear
                    break 
                    ;;
                4) 
                    clear
                    exec bash
                    ;;
                0) 
                    exit 
                    ;;
            esac
        fi

    done
}

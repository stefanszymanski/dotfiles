#!/usr/bin/env bash

# Query cht.sh in a new tmux window
# Copied from https://github.com/ThePrimeagen/.dotfiles/blob/68b6835ae340e5adbf6a92a7bdb238e0d7aa334f/bin/.local/bin/tmux-cht.sh

WAIT=" & while [ : ]; do sleep 1; done"

selected=$(cat ~/.tmux-cht-languages ~/.tmux-cht-commands | fzf)
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
    query=$(echo "$query" | tr ' ' '+')
    tmux neww bash -c "curl cht.sh/$selected/$query $WAIT"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query $WAIT"
fi

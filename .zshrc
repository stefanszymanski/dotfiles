# See http://zsh.sourceforge.net/Doc/Release/Options.html

fpath=(~/.local/share/zsh/completion $fpath)

zmodload -i zsh/complist


###########
# PLUGINS #
###########

### Install zinit if not present
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \

zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

zinit wait'0b' lucid light-mode for \
    zsh-vi-more/vi-increment \
    zsh-vi-more/vi-motions \
    lukechilds/zsh-nvm

zinit wait'1' lucid light-mode for \
    ael-code/zsh-colored-man-pages \
    peterhurford/up.zsh


##############
# COMPLETION #
##############

setopt auto_list                    # automatically list choices on an ambiguous completion
setopt auto_menu                    # use menu completion after the second consecutive request for completion
setopt auto_remove_slash            # when the last autocompleted char is a slash and a space is typed next, remove the slash
setopt complete_in_word             # allow completion inside a word
setopt glob_complete                # autocomplete globs instead of replacing them with matches
setopt always_to_end                # move cursor to the end of a word if completion is performed from within
setopt no_complete_aliases          # complete aliases instead of expanding them
unsetopt list_ambiguous             # on ambiguous completions insert an unambiguous prefix and display choices

# display completion choices as menu
zstyle ':completion:*:*:*:*:*' menu select

# case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

# colorful completion
zstyle ':completion:*' list-colors ${(s.:.)EXA_COLORS}

# formats
zstyle ':completion:*:descriptions' format $'%{\e[0;34m%}%B%d%b%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
zstyle ':completion:*:messages' format $'%{\e[0;34m%}%d%{\e[0m%}'
zstyle ':completion:*' format $'%{\e[0;33m%}%B%d%b%{\e[0m%}'

# group choices
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' separate-sections true

# enhance process completion
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm,time,command -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# complete . and ..
zstyle ':completion:*' special-dirs true

# sort choices by name
zstyle ':completion:*' file-sort name

# don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# host names from .ssh/config
if [[ -r ~/.ssh/config ]]; then
    h=(${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
    zstyle ':completion:*:(ssh|sshp|scp|sftp|rsh|rsync):*' hosts $h
fi

# use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs \
        'nixbld*' polkitd rtkit _uuidd
# ... unless we really want to.
zstyle '*' single-ignored show

# ignore functions starting with _
zstyle ':completion:*:functions' ignored-patterns '_*'

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

# load completion for the gitlab cli tool
source <(glab completion -s zsh); compdef _glab glab


##############
# CORRECTION #
##############

setopt correct                      # enable spelling correction of commands
# setopt dvorak                       # use Dvorak keyboard layout as basis for examining spelling mistakes

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias sudo='nocorrect sudo'
alias ln='nocorrect ln'


###########
# HISTORY #
###########

if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=100000
SAVEHIST=100000

setopt append_history               # session appends its history to the history file
setopt extended_history             # save timestamp and duration for entries
setopt hist_expire_dups_first       # delete old duplicates first
setopt hist_ignore_dups             # do not add to history if duplicate of previous command
setopt hist_ignore_all_dups         # remove older duplicate entries, even if not contiguous
setopt hist_find_no_dups            # do not show non-contiguous duplicates
setopt hist_ignore_space            # remove entries starting with a space
setopt hist_verify                  # show command instead of directly executing it
setopt inc_append_history           # add as soon as entered, not when the command finishs executing
setopt share_history                # share history between sessions


############
# BINDINGS #
############

# enable vim mode
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \

zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

zinit wait'0b' lucid light-mode for \
    zsh-vi-more/vi-increment \
    zsh-vi-more/vi-motions \
    lukechilds/zsh-nvm

zinit wait'1' lucid light-mode for \
    ael-code/zsh-colored-man-pages \
    peterhurford/up.zsh
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \

zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

zinit wait'0b' lucid light-mode for \
    zsh-vi-more/vi-increment \
    zsh-vi-more/vi-motions \
    lukechilds/zsh-nvm

zinit wait'1' lucid light-mode for \
    ael-code/zsh-colored-man-pages \
    peterhurford/up.zsh
bindkey -M vicmd '^v' edit-command-line

# BINDINGS - READLINE

# moving
bindkey -M viins '^a'        beginning-of-line
bindkey -M viins '^e'        end-of-line
bindkey -M viins '^f'        forward-char
bindkey -M viins '^b'        backward-char
bindkey -M viins '^[f'       forward-word
bindkey -M viins '^[b'       backward-word
# history
bindkey '^[p'       up-history
bindkey '^[n'       down-history
bindkey '^p'        history-beginning-search-backward
bindkey '^n'        history-beginning-search-forward
bindkey '^r'        history-incremental-search-backward
bindkey '^s'        history-incremental-search-forward
# text editing
bindkey -M viins '^d'        delete-char
bindkey -M viins '^w'        backward-kill-word

# OTHER BINDINGS

# completion
bindkey -M menuselect " "       accept-and-menu-complete
bindkey -M menuselect "\C-?"    undo                        # backspace
bindkey -M menuselect "j"       menu-complete
bindkey -M menuselect "k"       reverse-menu-complete


#######
# GPG #
#######

# see https://dev.gnupg.org/T3412
export GPG_TTY=$(tty)

# see https://www.gnupg.org/documentation/manuals/gnupg/Common-Problems.html
function _gpg-agent-update-tty {
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null
}
if [ -z "$preexec_functions" ]; then
    preexec_functions=()
fi
preexec_functions+=_gpg-agent-update-tty


########
# MISC #
########

WORDCHARS='*?[]~&;!#$%^(){}<>'

# changing directories
setopt auto_cd                      # change directories without cd
setopt auto_pushd                   # make cd push the old directory onto the directory stack
setopt cdable_vars
setopt pushd_ignore_dups            # don't push multiple copies of the same directory onto the stack

# input / output
setopt hash_cmds                    # note the location of each command the first time it is executed
setopt hash_dirs                    # when hashing command names, also hash the directory containing it
setopt interactive_comments         # allow comments in interactive shell

# job control
setopt check_jobs                   # check for background jobs before exiting a shell
setopt check_running_jobs           # also check for running jobs before exiting a shell
setopt hup                          # send the HUP signal to running jobs when existing a shell

export KEYTIMEOUT=1                 # Set timeout of the escape key to 0.1 seconds


###########
# ALIASES #
###########

# shortening often used commands
alias g='git'
alias gl='glab'

# dotfile versioning
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias pconfig='/usr/bin/git --git-dir=$HOME/.dotfiles-private/ --work-tree=$HOME'

# work dotfiles
alias wconfig='/usr/bin/git --git-dir=$HOME/.dotfiles-work/ --work-tree=$HOME'
alias wdeployconfig='/usr/bin/git --git-dir=$HOME/work/projects/deploy.confd/.git --work-tree=$HOME/work/projects/deploy.confd'

# work password store
alias wpass='PASSWORD_STORE_DIR=$HOME/.password-store-work/ pass'

# vim as pager
alias vless='/usr/share/nvim/runtime/macros/less.sh'

# nvim due to problem with prompts from external programs
alias nvim='PINENTRY_USER_DATA=gtk nvim'
alias vim=nvim
alias v=nvim

# cal
alias cal='ncal -bwM'

# exa
if type exa &> /dev/null; then
	alias ls='exa'
	alias l='exa --long --binary --classify --git --time-style=long-iso'
	alias ll='l --group --modified --accessed --header'
	alias la='l --all'
    alias lla='ll --all'
	alias lx='ll --links --inode --blocks --extended --color-scale'
    alias lxa='lx --all'
	alias lS='exa -1'
fi
# exa tree view
function lt {
    if [ -n "$1" ]; then
        exa --tree --level="$1"
    else
        exa --tree --level=2
    fi
}

# fasd
alias o='fasd -a -e xdg-open'

# runit user services
function usv { SVDIR=~/service sv $@ }
function uvsv { SVDIR=~/service vsv $@ }
function uxsv { SVDIR=~/service.x sv $@ }
function uxvsv { SVDIR=~/service.x vsv $@ }

# backlightcontrol
alias bl='de-backlight'
alias bl0='de-backlight set 0'
alias bl1='de-backlight set 100'

# web services
alias share='nc termbin.com 9999 | xclip -in -selection clipboard && printf "%s\n" "Link copied to clipboard" || printf "%s\n" "An error occured"'

# khal (wip)
alias iwcal='ikhal -c $HOME/.config/khal/config-work'
alias ipcal='ikhal'
alias pcal='khal list'

# = as calculator
autoload -U zcalc
function __calc_plugin {
    zcalc -e "$*"
}
aliases[=]='noglob __calc_plugin'

# zmv
autoload -U zmv
alias zmv='noglob zmv'
alias mmv='noglob zmv -W'
alias mcp='noglob zmb -C'


########################
# SHELL INITIALISATION #
########################

# Load fzf
if [ -r ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
else
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi

eval "$(starship init zsh)"
eval "$(fasd --init auto)"

export NVM_DIR="$HOME/.config/nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true

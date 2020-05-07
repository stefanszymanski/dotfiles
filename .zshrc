# See http://zsh.sourceforge.net/Doc/Release/Options.html

fpath=(~/.local/share/zsh/completion $fpath)

zmodload -i zsh/complist

###########
# PLUGINS #
###########

source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "ael-code/zsh-colored-man-pages", defer:2
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "peterhurford/up.zsh"
zplug "MichaelAquilina/zsh-autoswitch-virtualenv"
zplug load


##############
# COMPLETION #
##############

setopt auto_list                    # automatically list choices on an ambiguous completion
setopt auto_menu                    # use menu completion after the second consecutive request for completion
setopt complete_in_word             # allow completion inside a word
setopt always_to_end                # move cursor to the end of a word if completion is performed from within
setopt no_complete_aliases          # complete aliases (yeah, the option name is strange)
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

# custom commands
compdef _hosts sshp


##############
# CORRECTION #
##############

setopt correct                      # enable spelling correction of commands
setopt dvorak                       # use Dvorak keyboard layout as basis for examining spelling mistakes

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias gist='nocorrect gist'
alias sudo='nocorrect sudo'


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

# BINDINGS - READLINE

# moving
bindkey '^a'        beginning-of-line
bindkey '^e'        end-of-line
bindkey '^f'        forward-char
bindkey '^b'        backward-char
bindkey '^[f'       forward-word
bindkey '^[b'       backward-word
# history
bindkey '^p'        up-history
bindkey '^n'        down-history
bindkey '^r'        history-incremental-search-backward
bindkey '^s'        history-incremental-search-forward
# text editing
bindkey '^d'        delete-char
bindkey '\e[3~'     delete-char     # delete
bindkey '^t'        transpose-chars
bindkey '^[t'       transpose-words
bindkey '^[u'       up-case-word
bindkey '^[l'       down-case-word
bindkey '^[c'       capitalize-word
# killing and yanking
bindkey '^[d'       forward-kill-word
bindkey '^w'        backward-kill-word
# miscellaneous
bindkey '^[#'       pound-insert
bindkey '^[_'       undo

# BINDINGS - OTHERS

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

WORDCHARS='*?_-[]~&;!#$%^(){}<>'

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

# dotfile versioning
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias pconfig='/usr/bin/git --git-dir=$HOME/.dotfiles-private/ --work-tree=$HOME'

# vim as pager
alias vless='/usr/share/nvim/runtime/macros/less.sh'

# nvim due to problem with prompts from external programs
alias nvim='PINENTRY_USER_DATA=gtk nvim'
alias vim=nvim

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
alias v='fasd -e nvim'
alias o='fasd -a -e xdg-open'

# khal (wip)
alias iwcal='ikhal -c $HOME/.config/khal/config-work'
alias ipcal='ikhal'
alias pcal='khal list'


########################
# SHELL INITIALISATION #
########################

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Load fzf
if [ -r ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
else
    source /usr/share/doc/fzf/key-bindings.zsh
    source /usr/share/doc/fzf/completion.zsh
fi

eval "$(starship init zsh)"
eval "$(fasd --init auto)"

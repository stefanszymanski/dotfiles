# See http://zsh.sourceforge.net/Doc/Release/Options.html

# A lot was taken from https://github.com/changs/slimzsh and customizing these configs is still in progress

source ~/.zplug/init.zsh

fpath=(~/.local/share/zsh/completion $fpath)

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Add some plugins
zplug "ael-code/zsh-colored-man-pages", defer:2
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "peterhurford/up.zsh"
zplug "MichaelAquilina/zsh-autoswitch-virtualenv"

# Set the theme
# zplug "robobenklein/zinc", as:theme, at:dev

## Add directory for custom prompt segments
#fpath+=("$HOME/.config/zsh/zinc/segments")
## Modify segment options
#typeset -gA zinc_opts
#zinc_opts=(
#  zincs_execution_time "black;yellow;;;10"      # changed colours and threshold
#)
## Setup prompt
#typeset -ga zinc_left zinc_right
#zinc_left=(
#	zincs_cwd_writable
#	zincs_cwd
#	#zincs_vcs
#	zincs_vi_mode_indicator
#)
#zinc_right=(
#    zincs_retval
#    #zincs_virtualenv
#    zincs_execution_time
#    #zincs_time
#)

# Change cursor shape depending on vi mode
#function zle-keymap-select zle-line-init {
#  case $KEYMAP in
#    vicmd) echo -ne '\e[1 q';; # block cursor
#    viins|main) echo -ne '\e[5 q';; # beam cursor
#    #*) echo -ne '\e[5 q';; # beam cursor
#  esac
#}
#zle -N zle-keymap-select
#zle -N zle-line-init

# source ~/.config/zsh/vi_mode_indicator

# MODE_CURSOR_VICMD="steady block"
# MODE_CURSOR_VIINS="steady bar"
# MODE_CURSOR_SEARCH="steady underline"

# COMPLETION
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end


# case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''

zstyle ':completion:*:*:*:*:*' menu select
# Enhance process completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm,time,command -w -w"
# Disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# Enhance host name completion
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

zstyle ':completion:*' users off

# Use caching so that commands like apt and dpkg complete are useable
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
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
# ... unless we really want to.
zstyle '*' single-ignored show

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi


# CORRECTION
setopt correct_all
alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias gist='nocorrect gist'
alias sudo='nocorrect sudo'


# HISTORY
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoredups

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history


# Enable vi mode
bindkey -v

# Set timeout of the escape key to 0.1 seconds
export KEYTIMEOUT=1

# see https://dev.gnupg.org/T3412
GPG_TTY=$(tty)
export GPG_TTY

# BINDINGS

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward


# ALIASES

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


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


# Load the plugins
zplug load # --verbose

# Load fzf
if [ -r ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
else
    source /usr/share/doc/fzf/key-bindings.zsh
    source /usr/share/doc/fzf/completion.zsh
fi

eval "$(starship init zsh)"
eval "$(fasd --init auto)"

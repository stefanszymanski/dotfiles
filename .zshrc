# See http://zsh.sourceforge.net/Doc/Release/Options.html

# A lot was taken from https://github.com/changs/slimzsh and customizing these configs is still in progress

source ~/.zplug/init.zsh

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Add some plugins
zplug "ael-code/zsh-colored-man-pages", defer:2
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "peterhurford/up.zsh"

# Set the theme
zplug "robobenklein/zinc", as:theme

# Add directory for custom prompt segments
fpath+=("$HOME/.config/zsh/zinc/segments")
# Modify segment options
typeset -gA zinc_opts
zinc_opts=(
  zincs_execution_time "black;yellow;;;10"      # changed colours and threshold
)
# Setup prompt
typeset -ga zinc_left zinc_right
zinc_left=(
	zincs_cwd_writable
	zincs_cwd
	zincs_vcs
)
zinc_right=(
    zincs_retval
    zincs_virtualenv
    zincs_execution_time
    zincs_time
)

# Change cursor shape depending on vi mode
function zle-keymap-select zle-line-init {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';; # block cursor
    viins|main) echo -ne '\e[5 q';; # beam cursor
    #*) echo -ne '\e[5 q';; # beam cursor
  esac
}
zle -N zle-keymap-select
zle -N zle-line-init


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

# ALIASES

# dotfile versioning
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias config-mail='/usr/bin/git --git-dir=$HOME/.dotfiles-mail/ --work-tree=$HOME'

# vim as pager
alias vless='/usr/share/nvim/runtime/macros/less.sh'

# exa
if type exa &> /dev/null; then
	alias ls='exa'                                                         # ls
	alias l='exa -lbF --git'                                               # list, size, type, git
	alias ll='exa -lbGF --git'                                             # long list
	alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
	alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
	alias lS='exa -1'                                                      # one column, just names
fi
# exa tree view
function lt {
    if [ -n "$1" ]; then
        exa --tree --level="$1"
    else
        exa --tree --level=2
    fi
}


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
source ~/.fzf.zsh

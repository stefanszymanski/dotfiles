# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.bin" ] && PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.local/share/JetBrains/Toolbox/bin" ] && PATH="$HOME/.local/share/JetBrains/Toolbox/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.npm/bin" ] && PATH="$HOME/.npm/bin:$PATH"
[ -d "$HOME/.composer-vendor/bin" ] && PATH="$HOME/.composer-vendor/bin:$PATH"
[ -d "/usr/lib/ruby/gems/2.7.0/bin" ] && PATH="/usr/lib/ruby/gems/2.7.0/bin:$PATH"
export PATH

# set XDG_CONFIG_* variables
export XDG_CONFIG_HOME="$HOME/.config"

# set ripgrep configuration file
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# use gpg-agent as ssh-agent replacement
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# set exa colours
# copied from https://github.com/fenetikm/falcon/blob/master/exa/EXA_COLORS
export EXA_COLORS="uu=38;5;249:un=38;5;241:gu=38;5;245:gn=38;5;241:da=38;5;245:sn=38;5;7:sb=38;5;7:ur=38;5;3;1:uw=38;5;5;1:ux=38;5;1;1:ue=38;5;1;1:gr=38;5;249:gw=38;5;249:gx=38;5;249:tr=38;5;249:tw=38;5;249:tx=38;5;249:fi=38;5;248:di=38;5;253:ex=38;5;1:xa=38;5;12:*.png=38;5;4:*.jpg=38;5;4:*.gif=38;5;4"

export EDITOR=nvim

# Load host specific configuration
HOST_PROFILE="$HOME/.config/env/profile.$(hostname)"
if [ -e "$HOST_PROFILE" ] ; then
    . "$HOST_PROFILE"
fi

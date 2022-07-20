## ~/.bashrc
#
#| |__   __ _ ___| |__  _ __ ___
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__
#|_.__/ \__,_|___/_| |_|_|  \___|
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#neofetch small

#ble.sh bash w vi-mode and auto-completion
##[[ $- == *i* ]] && source $HOME/.local/src/blesh/ble.sh --noattach

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

#export PS1="[\u@\h ~]\\$\[$(tput sgr0)\]"

#susexport PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 6)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"


#auto cd 
## Allows you to cd into directory merely by typing the directory name.
shopt -s autocd

#vi mode in bash (uncomment after expertise)
set -o vi

#Ctrl+D EOF Signal will work on billionth press
#export IGNOREEOF=1000000000
set -o ignoreeof


export PATH="$PATH:$HOME/.scripts"
# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$HOME/.local/bin"
export SUDO_ASKPASS="$HOME/.local/bin/dpass"


#infinite history
HISTSIZE= HISTFILESIZE= 
#timecodes in bash history :))
#HISTTIMEFORMAT="%d/%m/%y %T "
HISTTIMEFORMAT="%F %T"
#ignore dupes
export HISTCONTROL=ignoredups:erasedups

#XDG
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export HISTFILE="${XDG_STATE_HOME}/bash/history"

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
#partially supported XDG Base Directory
[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"

#[[ ${BLE_VERSION-} ]] && ble-attach

export N_PREFIX="$HOME/.local/usr/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

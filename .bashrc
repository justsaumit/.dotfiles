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

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

#export PS1="[\u@\h ~]\\$\[$(tput sgr0)\]"

#susexport PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 6)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"


#auto cd 
## Allows you to cd into directory merely by typing the directory name.
shopt -s autocd

#vi mode in bash (uncomment after expertise)
#set -o vi

#Ctrl+D EOF Signal will work on billionth press
#export IGNOREEOF=1000000000
set -o ignoreeof

#Solana path env 13-9-21
export PATH="$PATH:/home/saumit/.local/share/solana/install/active_release/bin"

#infinite history
HISTSIZE= HISTFILESIZE= 
#timecodes in bash history :))
#HISTTIMEFORMAT="%d/%m/%y %T "
HISTTIMEFORMAT="%F %T"
#ignore dupes
HISTCONTROL=ignoredups

#Some aliases
alias te="teams"
alias w="whatsapp-nativefier"
alias v="vim"
alias sv="sudo vim"
alias r="ranger"
alias sr="sudo ranger"
alias space="ncdu"
alias c='clear'
alias h='history'
alias sha="shasum -a 256"
alias untar="tar -zxvf"
alias cp="cp -iv"
alias mv="mv -iv"
alias mkd="mkdir -pv" #make a parent and sub directory
alias myip="curl ipinfo.io/ip && echo """

#git
alias gc="git commit"
alias gd="git diff"
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''%C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"

alias jds="export _JAVA_AWT_WM_NONREPARENTING=1"
alias jd="jdownloader"
alias polkit="/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
alias scr="ffmpeg -f x11grab -i :0.0 out.mp4"
alias ss="maim -D --select | tee ~/Pictures/Screenshots/pic-sel-$(date '+agy-%m-%d--%H-%M-%S').png | xclip -selection clipboard -t image/png
maim --select | tee ~/Pictures/Screenshots/pic-full-$(date '+%Y-%m-%d--%H-%M-%S').png | xclip -selection clipboard -t image/png"
alias pas="pulseaudio --start"
alias pak="pulseaudio --kill"
alias pm="pulsemixer"
alias sp="spotify"

alias b="brave"
alias bb="brave --incognito"
alias bbb="brave --tor"
alias hab="brave habitica.com"
alias toggl="brave track.toggl.com/timer"
alias github="brave https://github.com/Saumit-D"

alias ff="librewolf"
alias br="brightnessctl set "
alias rs="redshift -P -O"
alias t="tuxi"
alias prime="prime-run " #enable hardware acceleration
#alias st="cd st"
alias dwm="cd dwm"
alias setntp="timedatectl set-ntp true"
alias rm="trash"
#alias listdel ="cd /home/saumit/.local/share/Trash && ls"
alias listdel="trash-list"
alias restore="trash-restore"
alias empty="trash-empty"

alias yt="ytfzf -t"
alias ytm="ytfzf -ml"
alias ytq="ytfzf -faH"
alias leaf="notepadqq"
alias qb="qbittorrent"
alias q="exit"

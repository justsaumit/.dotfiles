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
PS1='[\u@\h \W]\$ '


#auto cd 
## Allows you to cd into directory merely by typing the directory name.
shopt -s autocd

#vi mode in bash (uncomment after expertise)
#set -o vi




#infinite history
HISTSIZE= HISTFILESIZE= 
#timecodes in bash history :))
HISTTIMEFORMAT="%d/%m/%y %T "

#Some aliases
alias t="teams"
alias w="whatsapp-nativefier"
alias v="vim"
alias sv="sudo vim"
alias r="ranger"
alias sr="sudo ranger"
alias mkd="mkdir -v"
alias rmd="rmdir -v"
alias jd="jdownloader"
alias scr="ffmpeg -f x11grab -i :0.0 out.mp4"
alias ss="maim --select | tee ~/Pictures/Screenshots/pic-full-$(date '+%Y-%m-%d--%H-%M-%S').png | xclip -selection clipboard -t image/png"
alias pas="pulseaudio --start"
alias pak="pulseaudio --kill"
alias sp="spotify"
alias b="brave"
alias br="brightnessctl set "
alias rs="redshift -P -O"
alias prime="prime-run " #accelerate hardware 
alias st="cd st"
alias dwm="cd dwm"
alias yt="ytfzf"

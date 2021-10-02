# ~/.bash_profile
# _               _                           __ _ _
#| |__   __ _ ___| |__       _ __  _ __ ___  / _(_) | ___
#| '_ \ / _` / __| '_ \     | '_ \| '__/ _ \| |_| | |/ _ \
#| |_) | (_| \__ \ | | |    | |_) | | | (_) |  _| | |  __/
#|_.__/ \__,_|___/_| |_|____| .__/|_|  \___/|_| |_|_|\___|
#                     |_____|_|

#Runs on log in


export PATH="$PATH:$HOME/.scripts"
#your $PATH env variable is a list of all your directories from which you can run commands without giving the whole location 
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="brave"
export READER="zathura"
//export HABITICA_TOKEN=" "
//export HABITICA_UUID=" "




[[ -f ~/.bashrc ]] && . ~/.bashrc


#if tty -> tty1 then upon login execute/run the X graphical server
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
		exec startx
fi



#Switch escape and Caps Lock 
#sudo -n loadkeys ~/.scripts/ttymaps.kmap 2>/dev/null



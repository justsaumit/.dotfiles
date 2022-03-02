##zshell configuration

# Enable colors and have a proper PS1
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%~%{$fg[red]%}]%{$reset_color%}$%b "

# defines different colors for files in ls output(by default in bash)
alias ls='ls --color'

# History in cache directory
HISTSIZE=
SAVEHIST=
HISTFILE=~/.cache/zsh/zsh_history

# Basic auto/tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zmodload zsh/complist
compinit
_comp_options+=(globdots)       #include hidden files

#auto cd
setopt autocd extendedglob nomatch

##vi mode
#bindkey -v
#export KEYTIMEOUT=1

# Use vim keys in tab compete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-up-line-or-history
bindkey -M menuselect 'k' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Change cursor shape for different vi modes.
#function zle-keymap-select {
#    if [[ ${KEYMAP} == vicmd ]] || 
#       [[ $1 = 'block' ]]; then
#      echo -ne 'e[1 q'
#    elif [[ ${KEYMAP} == main ]] ||
#         [[ ${KEYMAP} == viins ]] ||
#         [[ ${KEYMAP} == '' ]] ||
#         [[ $1 = 'line' ]]; then
#      echo -ne '\e[5 q'
#    fi
#}
#zle -N zle-keymap-select
#zle-line-init() {
#    zle -K viins
#    echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[1 q' #default to block cursor



# Key Bindings
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
# [[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete



#key[Control-Left]="${terminfo[kLFT5]}"
#key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Load aliases 
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"


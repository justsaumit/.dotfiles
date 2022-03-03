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
# Auto complete with case-insensitivity
zstyle ':completion::complete:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}''r:[._-]=* r:|=*' 'l:|=*' 'r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)       #include hidden files

#auto cd
setopt autocd extendedglob nomatch

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

##vi mode
#bindkey -v
#export KEYTIMEOUT=1

# Use vim keys in tab compete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Fix backspace bug when switching modes
# bindkey ""^?" backward-delete-char

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

# Open typed text in a vim buffer
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line


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

# Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Suggest aliases for commands
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
# Search repos for programs that can't be found
source /usr/share/doc/find-the-command/ftc.zsh

# Spaceship Prompt
autoload -U promptinit; promptinit
prompt spaceship

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CHAR_SYMBOL_ROOT=❯❯
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_COLOR_SUCCESS=green
SPACESHIP_CHAR_COLOR_FAILURE=red

SPACESHIP_HG_SHOW=false
SPACESHIP_PACKAGE_SHOW=false

SPACESHIP_EXEC_TIME_SHOW=true
SPACESHIP_EXEC_TIME_PREFIX=took·
SPACESHIP_EXEC_TIME_COLOR=yellow

SPACESHIP_NODE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=true
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_DOCKER_CONTEXT_SHOW=true
SPACESHIP_AWS_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_VENV_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_VI_MODE_SHOW=true
SPACESHIP_JOBS_SHOW=false

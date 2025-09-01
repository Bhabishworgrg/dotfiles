#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

trap '. ~/.bash_logout' EXIT

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias git-lucas='git config user.name "LucasBeastBeast" && git config user.email "nikal.gurung@gmail.com"'
alias git-bhabhi='git config user.name "Bhabishworgrg" && git config user.email "bhabishworgrg@gmail.com"'
alias git-college='git config user.name "Bhabishwor" && git config user.email "gbhabishwor22@tbc.edu.np"'
alias fastfetch='pokemon-colorscripts --no-title -r > ~/.config/fastfetch/pokemon_logo.txt && fastfetch'
alias matlab='LD_PRELOAD=/usr/lib/libgcc_s.so.1 matlab'
alias session='kitty --session ${PWD}/session.kitty --detach && exit'

. "$HOME/.cargo/env"

. ~/.local/bin/bashmarks.sh

export EDITOR=nvim

export PATH=$PATH:$HOME/odoo
export PATH="$PATH:/home/lucasbeastbeast/.dotnet/tools"

eval "$(starship init bash)"

fastfetch

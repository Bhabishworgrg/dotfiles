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
alias live-preview='browser-sync start --server --files "*.html" "*.css" "*.js"'
alias activate='source ~/myenv/bin/activate'
alias init-opencv='$HOME/Projects/init-opencv/script.sh'
alias fastfetch='pokemon-colorscripts --no-title -r > ~/.config/fastfetch/pokemon_logo.txt && fastfetch'

. "$HOME/.cargo/env"

source ~/.local/bin/bashmarks.sh

export EDITOR=nvim

export PATH=$PATH:$HOME/EhhLang
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/EhhLang/linux

export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

export PATH=$PATH:$HOME/odoo

eval "$(starship init bash)"

fastfetch

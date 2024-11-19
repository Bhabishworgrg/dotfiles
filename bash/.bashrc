#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

trap '. ~/.bash_logout' EXIT

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias build-win='dotnet build -r win-x64 --sc'
alias git-lucas='git config user.name "LucasBeastBeast" && git config user.email "nikal.gurung@gmail.com"'
alias git-bhabhi='git config --global user.name "Bhabishworgrg" && git config user.email "bhabishworgrg@gmail.com"'
alias live-preview='browser-sync start --server --files "*.html" "*.css" "*.js"'

. "$HOME/.cargo/env"

source ~/.local/bin/bashmarks.sh

export EDITOR=nvim
export PATH=$PATH:$HOME/EhhLang
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/EhhLang/linux

export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

eval "$(starship init bash)"

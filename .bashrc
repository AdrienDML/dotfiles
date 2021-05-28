#
# ~/.bashrc
#

# If not running interactively, don't do anything fd5ff0
[[ $- != *i* ]] && return
PS1="\[\e[38;2;102;217;239m\][\A]\[\e[38;2;166;226;46m\]\u\[\e[0;m\]:\[\e[38;2;253;95;240m\]\w\[\e[0;m\]\[\e[38;2;166;226;46m\]>\[\e[0;m\] "

alias source='source ~/.bashrc'
alias cat='bat'
alias ls='exa'
alias la='exa -a -l'
alias lg='exa -l --git --header'
alias lga='exa -a -l --git --header'
lt() {
    exa --tree --level=$1
}

ltg() {
    dir=${1:-'.'}
    exa $dir --tree --long --git --header
}

mkcd() {
    mkdir $1
    cd $1
}
. "$HOME/.cargo/env"

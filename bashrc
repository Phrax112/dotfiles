#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#####################################################################
# Prompt settings
#####################################################################

cyan=$(tput setaf 6)
purple=$(tput setaf 5)
reset=$(tput sgr0)
PS1='\[$purple\][\[$cyan\]\u \W\[$purple\]]$ \[$reset\]'
PROMPT_COMMAND="history -a; history -n"

#####################################################################
# Aliases
#####################################################################

alias ls='ls --color=auto'
alias ll='ls -lhtr --color=auto'
alias vi='vim'
alias psg=' ps -ef | grep -v grep | grep -i '
alias bfeed='ssh -oStrictHostKeyChecking=off gmoy@35.246.78.170'
alias wk="cd ~/workspace"
alias k="rlwrap k"
alias vpn='protonvpn'
alias g="cd /home/gmoy/go/src"

#####################################################################
# Environmental variables
#####################################################################

export GOPATH='/home/gmoy/go'
export GIT_EDITOR='vim'
export INPUTRC=~/.inputrc
shopt -s checkwinsize
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000000

#####################################################################
# Functions
#####################################################################

function alarmer() {
    sleep $1
    cvlc --play-and-exit /home/gmoy/Downloads/service-bell_daniel_simion.mp3 
}

function alarm() {
    date
    alarmer $1 >/dev/null 2&>1 &
    disown $!
}

function dprune() {
    docker system prune -f --volumes
}

function dra() {
    for cntr in `docker container ps -a | awk '{print $1}' | tail -n +2`; do
        docker container stop $cntr
        docker container rm $cntr
    done
}

function dls() {
    docker container ps -a
}

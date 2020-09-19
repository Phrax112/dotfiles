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
alias gitc="git_custom_commit"
alias gitp="git_custom_push"

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

function dlog() {
    docker logs $1
    }

function dls() {
    docker container ps -a
}

git_custom_commit() {
    #ticket=$(git rev-parse --abrev-ref HEAD | grep -Eo '^(\w+/)?(\w_[-_])?[0-9]' | grep -Eo '(\w+[-])?[0-9]+' | tr "[:lower:]" "[:upper:]")
    #if [[ $ticket == "" ]]; then
    #    echo "Ticket blank?"
    #    return 1
    #fi
    #cmd="git commit -m \"$ticket $1\""
    cmd="git commit -m \"$1\""
    echo $cmd
    eval $cmd
}

git_custom_push() {
    branch=$(git branch --show-current 2>/dev/null)
    if [[ $branch == "" ]]; then
        echo "Can't find branch?"
        return 1;
    fi
    cmd="git push -u origin $branch"
    echo $cmd
    eval $cmd
}

find_dotfile_diffs() {
    for f in $(ls | grep -v README); do
        diff -rq "$f" "$HOME/.${f}" | grep -v "^Only in*" | awk '{print $2}';
    done
}

sync_dotfiles() {
    cd ~/workspace/dotfiles
    git checkout -q master
    git pull -q
    diff_files=$(find_dotfile_diffs)
    for f in $diff_files; do
        echo "Syncing ${f} from dotfiles repo"
        cp -r "$f" "$HOME/.${f}"
    done
}

#sync_hosts="phrax phrax.host"
#if [[ $sync_hosts =~ (^|[[:space:]])"$HOSTNAME"($|[[:space:]]) ]]; then
#    sync_dotfiles
#fi

if [[ -z "$TMUX" ]]; then
    tmux
fi

function log_error {
	echo -e "\033[0;31m"$1"\033[0;m"
}

function try_source {
	{ [ -f $1 ] && source $1 } || log_error "File '$1' not found."
}


function try_source_silent {
	{ [ -f $1 ] && source $1 }
}


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

alias vim=nvim



# Use 'clean' for remotes and servers
#ZSH_THEME="clean"
ZSH_THEME="mh"

# Colorscheme from pywal
#(cat ~/.cache/wal/sequences &)
#wal -q --theme vscode &


# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
zsh-z
)
# Pretty completion for z plugin
zstyle ':completion:*' menu select

try_source $ZSH/oh-my-zsh.sh



# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"



bindkey -v # Vim keybindings

# Reverse history search
bindkey '^r' history-incremental-pattern-search-backward

# Open command in vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# Navigate menus with vim bindings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


try_source_silent $HOME/.fzf.zsh
try_source_silent /opt/ros/noetic/setup.zsh
try_source_silent $HOME/Ascend/mission9_pipeline/devel/setup.zsh

#export PATH="/home/torjusba/miniconda3/bin:$PATH"

alias plantuml="java -jar /home/torjusba/Downloads/plantuml.jar"
alias fd="/usr/bin/fdfind"

function plantuml_watch() {
  while sleep 1; do watch -gn .1 stat -c %Z "$1" && plantuml "$1"; done
}

function do_watch() {
    if [[ $1 == "" || $2 == "" ]]; then
        echo "Usage: do_watch <file> <command>"
        return
    fi
    while sleep 1; do watch -gn .1 stat -c %Z "$1" && $2; done
}

function va {
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    NC="\033[0m"
    if [[ $1 == "" ]]; then
        wd="."
    else
        wd="$1"
    fi
    echo -n "${RED}"  # For error messages from the source cmd
    source $wd/venv/bin/activate
    if [[ $? == 0 ]]; then
        echo "${GREEN}Sourced $wd/venv/bin/activate"
        return
    fi
    echo -n "${NC}"
}


export NOTES="$HOME/pkm"
export TOPOFMIND="$NOTES/_main/Top\ of\ mind.md"
alias tom="vim $TOPOFMIND"

function note() {
    suffix=""
    if [[ ! $1 =~ ".md" ]]; then
        suffix=".md"
    fi
    if [[ $1 != "" ]]; then
        vim -c "cd $NOTES" $NOTES/Inbox/$1$suffix
    else
        vim -c "cd $NOTES"
    fi
}

function avinote() {
    notepath=$NOTES/Aviant
    suffix=""
    if [[ ! $1 =~ ".md" ]]; then
        suffix=".md"
    fi
    if [[ $1 != "" ]]; then
        vim -c "cd $notepath" $notepath/$1$suffix
    else
        vim -c "cd $notepath"
    fi
}

function meeting_note() {
    meetingpath=$NOTES/Aviant/Meetings
    dateargs=""
    if [[ $2 != "" ]]; then
        dateargs="-d $2"
    fi
    vim -c "cd $meetingpath" $meetingpath/$(date -I $dateargs)-meeting-$1.md
    
}

function worklog() {
    worklogpath=$NOTES/Worklog
    dateargs=""
    if [[ $1 != "" ]]; then
        dateargs="-d $1"
    fi
    vim -c "cd $worklogpath" $worklogpath/worklog-$(date -I $dateargs).md
    
}

function recent() {
    find "$NOTES" -not -path "$NOTES/\.*" -type f -printf '%T@ %p\n' | sort -k1,1nr | head -n 100 | awk '{ print $NF }' | fzf --print0 --preview="cat {}" --delimiter / --with-nth -1 | xargs -0 -o nvim
}
alias re=recent
alias wl=worklog
alias mn=meeting_note
alias meet=meeting_note
alias todo="vim $NOTES/Aviant/todo.md"

alias pdftk="java -jar $HOME/.local/bin/pdftk-all.jar"
alias ghostscript="/usr/bin/gs"
alias gs="echo ghostsrcipt is aliased to /usr/bin/gs. Use ghostscript instead."

export PATH="/home/torjusba/go/bin:$PATH"
export PATH="/home/torjusba/.local/bin:$PATH"

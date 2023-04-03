#!/bin/bash

# SOME MOre ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -tcrhl'

alias ..="cd .."
alias ...="cd ../.."

function envproc() { echo $(( $(nproc)*2)); }

# REPO
# Login if needed and Sync the current projec
alias rs="git credential-corpsso check > /dev/null || glogin; repo sync -cj99 ."
# Login if needed and Sync all projects
alias rsa="git credential-corpsso check > /dev/null || glogin; repo sync -cj32"
alias rrb="repo rebase"
alias ra="repo abandon"
alias rdl="repo download"

# GIT
alias gsso="git credential-corpsso login"
alias gcn="gitbranchnum"
alias gtmp="git add -A && git commit -m TEMP" # Create a commit named TEMP
alias gdl="git diff --color=always | less -r" # Open git diff in less with colors

# upload a draft on gerrit
alias draft="repo upload -w --no-verify --cbr ."

# upload the current branch on gerrit
alias rupcb="repo upload --cbr ."
alias rupcby="repo upload --cbr -y ."

#invoke the cdiff tool
alias cdiff="cdiff -sw140"

# Reload bashrc
alias src="source ~/.zshrc"

alias gw="./gradlew"

# GREP
# greph: highlight each pattern into a its own color
function greph() {
    declare -a patterns
    declare -a args
    while [[ -n $1 ]] && [[ $1 != "-" ]] ; do

        if [[ $1 = -* ]] ; then
            args+=("$1")
        else
            patterns+=("$1|$")
        fi
        shift
    done

    if [[ $1 = "-" ]] ; then # Next argument is a file
        shift
    fi

    result=""
    while IFS= read line;  # IFS allows to keep whitespace when calling read.
    do
        color=1
        result=$line
        for pattern in "${patterns[@]}"; do
            result="$(echo -e "$result" | GREP_COLORS="mt=01;49;38;5;$color" grep --color=always -P "${args[@]/#/}" "$pattern")"
            color=$((color+1))
        done
        echo -e "$result"
        # result="$result\n$line"
    done < "${1:-/dev/stdin}"
}

# Diff between two files with highlighting
function grepd() {
    local file1=$1; shift
    local file2=$1; shift
    local diff=$( (wdiff "$file1" "$file2") )
    less -fr <(echo "$diff" | greph "$*" | colordiff )
    return 0
}


# Diff between current clipboard content and next clipboard content
function clipdiff() {
    local a="$(xclip -o -selection clip)";
    local b="$a"
    echo "Waiting for first copy..."
    while [ "$b" = "$a" ] ; do b="$(xclip -o -selection clip)"; sleep 1; done
    echo "Frist copy recorded."
    echo "Waiting for second copy..."
    a="$b"
    while [ "$a" = "$b" ] ; do a="$(xclip -o -selection clip)"; sleep 1; done
    echo "Second copy recorded."
    grepd <(echo "$b") <(echo "$a")
}

# Open vim and edit the given command
function vimc() {
    local command_path=""
    local pattern=""
    local use_code=false
    
    [[ "$1" == "-c" ]] && { use_code=true; shift; }
    
    local command=$1; shift
    if [[ -n ""$command"" ]] ; then
        command_path=$(which ""$command"")
        [[ -z $command_path ]] && { echo "Nothing found for "$command""; return 1; }

        if [[ ! -f $command_path ]] ; then
            command_path=$(type ""$command"" | rev | cut -d' ' -f1 | rev)
            pattern="+/function "$command""
        fi

        [[ ! -f $command_path ]] && { echo ""$command" is not a script"; return 2; }

        if [[ $use_code == true ]] ; then 
            local line=$(grep -nE "fun(ction)? $command" $command_path | cut -d':' -f1)
            code -g $command_path:$line
        else 
            vim ${pattern:+$pattern} "$command_path";
        fi
    fi
}

# Kill existing instance of Xephyr and start a new one
function xx(){ 
    killall Xephyr;
    DISPLAY=:0; 
    (Xephyr -ac -br -noreset  -resizeable -screen 2560x1600@43 :10 &); 
    sleep 1;
    DISPLAY=:10; 
    feh --bg-center --no-xinerama ~/Documents/wallpaper/LosAngeles-Night-View.jpg; 
    cinnamon2d --replace -d :10 & DISPLAY=:0;
}

# Start a new instance of Xephyr with a 4K resolution
alias x4k="(Xephyr -ac -br -noreset -nolock -dpi 230 -screen 3838x2140 :10 & metacity --replace -d=:10 &) >/dev/null 2>&1"
alias ii="ibus-daemon -rd"
alias 4k="xrandr   -d :0  --fb  3840x2160    --output    default"
alias hd="xrandr   -d :0  --fb  2560x1600    --output    default"

alias wallpaper="feh --bg-scale --no-xinerama ~/Documents/wallpaper/8k-mountain.jpg"

alias bazel="\$STUDIO_BASE/tools/base/bazel/bazel"


# Print all Java process with JVM arguments on separate lines
alias jpl="jps -vl | sed s/-/\"\n    >>>> -\"/g | sed -E 's/(^[0-9])/\n\1/g'"

# Functions
function killstudio () {
    kill ${1:--9} $(ps -aef | grep -v grep | grep AndroidStudio | tr -s ' ' | cut -d' ' -f2);
}

function killij () {
    local sig="$1"
    if [ -z "$sig" ] ; then
        sig="-15"
    fi
    processes=$(ps -aux | grep -E "\-Didea.platform.prefix=Idea" | grep -v grep)
    if [ -z "$processes" ] ; then
        echo "No IntelliJ session found"
        return 1
    fi
    pids=$(echo "$processes" | tr -s ' ' | cut -d' ' -f2 | tr '\n' ' ')
    echo "Killing $pids"
    kill $sig $(echo "$pids")
}

function killij () {
  local sig="$1"
  if [ -z $sig ] ; then
    sig="-15"
  fi
  processes=$(ps -aux | grep -E "\-Didea.platform.prefix=Idea" | grep -v grep)
  if [ -z $processes ] ; then
    echo "No IntelliJ session found"
    return -1
  fi
  pids=$(echo $processes | tr -s ' ' | cut -d' ' -f2 | tr '\n' ' ')
  echo "Killing $pids"
  kill $sig $(echo $pids)
}

# Open the url given as a parameter as a standalone window of Google Chrome
function app () {
    local profile=""
    local protocol=""
    local url=""
    local flags=""


    while [[ -n "$1" ]] ;
    do 
        if [[ $1 == -* ]]; then
            flags="$flags $1"
        elif [[ -f "$1"  ]]; then
            protocol="file://"
            url=$(readlink -f "$1")
        elif [[ $1 == *"://"* ]]; then
            url=$1
        elif [[ $1 != *"://"* ]]; then
            protocol="http://"
            url=$1
        elif [ -n "$1" ] ; then
            echo "Opening profile $1"
            profile="--profile-directory=$1"
        fi
        shift
    done
    google-chrome "$flags" --app="$protocol$url" "$profile";
}

function luck() {
    query=$(echo "$@" | tr ' ' '+')
    app "https://www.google.com/search?q=$query&btnI"
}

# Swich links to backup. Files with same prefix and with _ln and _bk suffix are
# needed
function swln() {
    if [ -e "./$1_bk" ];  then
        mv "$1" "$1_ln" && mv "$1_bk" "$1"
    elif [ -e "./$1_ln" ]; then
        mv "$1" "$1_bk" && mv "$1_ln" "$1"
    else
        return 1
    fi
}

# Rebase onto
function rebo {
    git rebase --onto "$1" HEAD^;
}

function ergo {
    cp "$1" ~/W/ergodoxez
    unzip "$1"
    NAME=$(basename "$1")
    pushd ~/W/ergodoxez || exit;
    make all file="$NAME";
    popd || exit;
}

function ergb {
    pushd ~/W/ergodoxez || exit;
    make build;
    popd || exit;
}


function fs() {
    i3-msg fullscreen > /dev/null && $*; i3-msg fullscreen > /dev/null
}

alias sp="i3-msg floating enable; i3-msg move scratchpad; i3-msg scratchpad show"

alias vimi3="vim $DOTFILE_DIR/i3/config"

# Display history
function hist() {
    local arg="*"
    [ -n "$1" ] && arg="$1"
    local HIST_GREP=$(history -n -m  "*$arg*" | uniq | tac)
    local command=$(echo "$HIST_GREP" | rofi -dmenu)
    [ -z "$command" ] && return 0

  # Print the prompt to simulate a user entry in the terminal
  print -nP "$PS1"
  print "$command"

  eval "$command" && print -s "$command" # Execute the command and add it to the history
}

alias mn="rofi -dmenu"

function totelegram() {

    if [[ ! -f ~/.telegram_token ]] ; then
        echo "No token defined in ~/.telegram_token"
        return 1
    fi
    
    TELEGRAM_BOT_TOKEN=$(cat ~/.telegram_token)
    VAR=$1
    while read message ;
    do
        curl -s -S -X POST \
            -H 'Content-Type: application/json' \
            -d "{\"chat_id\": \"348981135\", \"text\": \"$message\", \"disable_notification\": true}" \
            https://api.telegram.org/bot"$TELEGRAM_BOT_TOKEN"/sendMessage > /dev/null;
    done < "${VAR:-/dev/stdin}" ;
}

function notif() {
    [ -z "$1" ] && return 1
    notify-send "$1"; echo "$1" | totelegram > /dev/null
}

function clip() {
    xclip -selection clip
}

function lf() {
    if [ $# -lt 1 ] ; then 
        echo "Usage: lf [<dir>] <command> [args...]. "
        echo "Execute the command using the last modified file from the dir as argument"
        return 1
    fi
    dir="."
    command=""
    if [ $# -gt 1 ] ; then
        command=$1; shift
    fi
    dir=$1; shift
    file=$(ls -FtH1 $dir | grep -vE "@|/" | head -n 1)
    
    if [ -z $file ] ; then
        echo "No file in $dir"; return 1
    fi
    echo "$command" "$@" "$dir/$file"
    eval "$command" "$@" "\"$dir/$file\""
}

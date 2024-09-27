#!/bin/bash

DOTFILE_DIR=~/.dotfiles

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -tcrhl'

alias ..="cd .."
alias ...="cd ../.."

function envproc() { echo $(( $(nproc)*2)); }

# REPO
# Login if needed and Sync the current projec
alias rs="gsso; repo sync -cj99 ."
# Login if needed and Sync all projects
alias rsa="gsso; repo sync -cj32"
alias rrb="repo rebase"
alias ra="repo abandon"
alias rdl="repo download"
# Upload a draft on gerrit
alias rdraft="echo -n \"Temporary Commit message: \" && read msg && git add -A && git commit -a -m \"TEMP \$msg\" && { repo upload --wip -y --cbr --no-verify . ; git reset HEAD@{1} }"
# upload the current branch on gerrit
alias rupcb="repo upload --cbr ."
alias rupcby="repo upload --cbr -y ."

# GIT
alias gsso="gcertstatus --check_remaining=1h --quiet || glogin"
alias gcn="gitbranchnum"
alias gtmp="git add -A && git commit -m TEMP" # Create a commit named TEMP
alias gdl="git diff --color=always | less -r" # Open git diff in less with colors


#invoke the cdiff tool
alias cdiff="cdiff -sw140"

# Reload bashrc
alias src="source ~/.zshrc"

alias gw="./gradlew"

alias fd="fdfind"

# Highlight
source ~/.dotfiles/bin/h.sh

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

alias vimi3="vim $DOTFILE_DIR/i3/config"

# Open vim and edit the given command
function vimc() {
    local command_path=""
    local pattern=""
    local use_code=false

    [[ "$1" == "-c" ]] && { use_code=true; shift; }

    local command=$1; shift
    if [[ -n "$command" ]] ; then
        command_path=$(which "$command")
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

# Print all Java process with JVM arguments on separate lines
alias jpl="jps -vl | sed s/\ -/\"\n    >>>> -\"/g | sed -E 's/(^[0-9])/\n\1/g'"

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
    local message=""
    local chatid="5361565130"

    postMessage() {
        curl -s -S -X POST \
            -H 'Content-Type: application/json' \
            -d "{\"chat_id\": \"$chatid\", \"text\": \"$message\", \"disable_notification\": false}" \
            https://api.telegram.org/bot"$TELEGRAM_BOT_TOKEN"/sendMessage > /dev/null;
    }

    if [[ ! -f ~/.telegram_token ]] ; then
        echo "No token defined in ~/.telegram_token or env variable TELEGRAM_BOT_TOKEN"
        return 1
    fi

    TELEGRAM_BOT_TOKEN=$(cat ~/.telegram_token)

    if [[ -n $1 ]] ; then
        message=$@
        postMessage
    else
        while read message ;
        do
            postMessage
        done < "/dev/stdin" ;
    fi
}

function n() {
    # Run a command a notification when done
    "$@"
    result=$?
    result_verbose=""
    if [[ $result -eq 0 ]] ; then
        result_verbose="sucessfully"
        urgency=normal
    else
        result_verbose="with an error ($result)"

        urgency=critical
    fi

    msg="$(date +%T): $1 finised $result_verbose"

    notif "$1" "$msg" --urgency=$urgency
}

function notif() {
    [[ -z "$1" ]] && return 1
    local args=()
    local summary=''
    local message=""

    while [[ -n $1 ]] ; do
        if [[ $1 = "--"* ]] ;  then
            args+=("$1")
            shift
        else
            [[ $# -gt 1 ]] && { summary="$1"; shift; }
            message="$1"
            shift
        fi
    done

    notify-send -t 5000 "$summary" "$message" "${args[@]}" "$@"

    if [[ -n $summary ]] ; then
        message="$summary\n$message"
    fi
    totelegram "$message\n$*" > /dev/null
}

function clip() {
    xclip -selection clip
}

function lf() {
    if [[ $1 = "-h" ]] ; then
        echo "Usage: lf [<dir>] <command> [args...]. "
        echo "Execute the command using the last modified file from the dir as argument"
        return 1
    fi
    dir="."
    command=""
    if [[ -d $1 ]] ; then
         dir=$1; shift
    fi

    file=$(ls -FtH1 $dir | grep -vE "@|/" | head -n 1)

    if [ -z $file ] ; then
        echo "No file in $dir"; return 1
    fi

    if [[ $# = 0 ]] ; then
        echo $file
        return 0
    fi

    command="$1"; shift
    if [[ -z $command ]] ; then
        echo $dir/$file
        return 0
    fi

    echo "$command" "$@" "$dir/$file"
    "$command" "$@" "$dir/$file"
}

function gcon() {
    # Checkout a git branch by number
    local branches=$(git b)
    echo "$branches" | >&2 grep -n '^'
    read sel"?Branch: "
    br=$(echo $branches | awk "NR==$sel {print\$1}")
    git co $br
}

function rcode() {
    local host=$1
    local file=$2
    /usr/bin/code --remote ssh-remote+$host $file
}

function fh() {
    # History fuzzy search
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history | sort -u -k 2 | sort -n -k 1 -r ) | sort -u -k 2 | sort -n -k 1 -r | fzf +s | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

if ! which rofi >/dev/null; then
  alias rofi="fzf";
fi

function fout() {
    # Fuzzy search in tmux scrollback buffer and copy the selected line in the tmux paste buffer
    if ! which fzf >/dev/null ; then
        echo "fzf must be installed";
        return 1
    fi

    local query=""
    local scrollback=-1

    while [[ -n $1 ]] ; do
        case $1 in
            [0-9]*)
                scrollback=$1; shift;
            ;;
            [a-zA-Z]*)
                query="$query $1"; shift;
            ;;
            *)
                echo "$1 unrecognized"; return 1
        esac
    done

    local lines=$scrollback # 1000 line of scrollback of no arg supplied
    if [[ $lines -lt 0 ]] ; then
        lines=$(tmux display-message -p "#{history_size}")
    fi
    local buffer_name="tmux_fzf_tmp_buffer"
    tmux capture-pane -e -S -$lines -b $buffer_name || return 1

    # Compute the range, or 0 if negative
    local range_min="\$(( val = {n} - FZF_PREVIEW_LINES / 2 - 1, val > 0 ? val : 0 ))"
    local range_max="\$(( val = {n} + FZF_PREVIEW_LINES / 2,  val > 0 ? val : 0 )) "

    # Input command
    local input_command="tmux show-buffer -b $buffer_name"
    local input_length=$(eval $input_command | wc -l)

    # Invert the preview to match the scrolling direction
    local preview_command
    local grep_cmd="grep --color=always -iE \"(\$( echo {q} | tr -cd '[:alnum:]|^$' )|$)\" - "
    if which bat >/dev/null ; then
        preview_command="bat -n --color=always -r $range_min:$range_max -H \$(( {n} + 1 )) <(eval $input_command)  | $grep_cmd"
    else
        preview_command="cat <(eval $input_command) | tail -n+$range_min | head -n+\$FZF_PREVIEW_LINES  | $grep_cmd "
    fi

    # jump to the selected line in the TMUX scrollback buffer and select it
    local jump_to_line_cmd="tmux copy-mode; \
        tmux send-keys -X goto-line \$(( $input_length - {n} - 1 )); \
        tmux send-keys -X select-line; \
        tmux send-keys -X stop-selection; \
        tmux send-keys -X halfpage-down; \
        tmux send-keys -X middle-line; "

    if [[ -n $query ]] ; then
        query="-q $query"
    fi

    local out=$(eval $input_command | \
        fzf --height=100% --ansi --info=inline --border="horizontal" --margin=1 --padding=0 -e \
        --no-sort --tac \
        --preview "eval $preview_command" --preview-window "up,75%,nowrap" \
        --bind "ctrl-j:accept+execute(eval $jump_to_line_cmd)" \
        --bind "ctrl-p:toggle-preview" \
        --header 'CTRL-J: jump to the selected line | CTRL-P: toggle preview' \
        $query \
        )

    out=$(echo $out | sed "s/^\s*\(.*\)\s*/\1/gi")
    if [[ -n $out ]] ; then
        tmux set-buffer -w $out
        echo $out
        tmux pasteb
    fi
}

function fat() {
    # bat with fzf search
    local input;
    local tempinput;
    local extension;
    if ! [[ -f $1 ]] ; then
        input=$(mktemp)
        tempinput=$imput
        cat /dev/stdin > $input
    else
        input=$1
        extension=${$(basename $input)##*.}
    fi

    local max_line=$(wc -l $input | awk '{print$1}' )
#    local grep_cmd="grep --color=always -iE \"(\$( echo {q} | tr -cd '[:alnum:]|^$' )|$)\" - "

    local bold=$(tput smso)
    local normal=$(tput rmso)
    local grep_cmd="sed \"s;\({q}\);${bold}\1${normal};gi\" " #not working yet
    local preview_command
    local lang
    if bat -L | grep $extension >/dev/null ; then
        lang=(-l "$extension")
    fi
    preview_command="cat $input | bat -f --highlight-line {1} --style='auto' ${lang} | $grep_cmd | bat -f -n"

    bat -f --style='numbers' $input | \
    fzf --ansi --height=100% --ansi --info=inline --border="horizontal" --margin=1 --padding=0 -e \
        --no-sort --tac \
        --nth='2..' \
        --preview "$preview_command" --preview-window 'up,75%,wrap,+{1}+1/2'

    [[ -f $tempinput ]] && rm $tempinput
}

function fkill() {
  ps -aux | fzf --header-lines 1 --reverse --multi --height 20| awk '{print$2}' | xargs kill "$@"
}

function funzip() {
    # Unzip files in a zipped file using fzf
    if [[ -z $1 ]] ; then
        echo "Usage: funzip <zipfile>" >&2
        return 2
    fi

    local f
    local fz
    local outdir
    f=$1; shift
    outdir="$(basename $f)-extracted"
    mkdir $outdir
    fz=$(unzip -l $f | awk '{print$4}' | fzf --multi --header-lines=3 --reverse --height=90% \
    --header="Select files to extract. TAB to select. ENTER to validate");
    if [[ -n $fz ]] ; then 
        unzip -d $outdir $f $(echo $fz)
        echo "Extracted into $outdir"
        return 0 
    fi

    echo "No file selected. Aborting" >&2
    return 1
}

function ftree() {
    # tree with fzf, preview. Relative path of Selected line will be printed upon selection
    local header_lines=2
    local dir=${1:-.}
    local output_command="sh -c 'cat <(echo ${dir}/..) <(tree -fi ${dir} ) | tac | sed -n \$(( {n} + $header_lines + 1 ))p ' "
    cat <(echo ${dir}/..) <(tree -C ${dir} ) | tac | \
    fzf --ansi --header-lines=$header_lines \
    --bind "ctrl-space:become($output_command)" \
    --bind 'start:last' \
    --bind 'ctrl-p:toggle-preview' \
    --bind "enter:reload(cat <(echo ..) <(tree -C \$($output_command)) | tac)" \
    --preview="f=\$($output_command); [[ -f \$f ]] && bat -f \$f" \
    --preview-window="70%,hidden" \
    --height=~50% \
    --header="ctrl-p: Preview" \
    --tac \
    --layout=reverse-list
}

function fdzip() {
    # Find files within jars and or zips
    jar_pattern=$1
    find_pattern=$2
    dir=$3

    [[ -z $3 ]] && {echo "Error" >&2; return 1 }

    unzip_search_command='jar=$(echo {}); files=$(unzip -l $jar 2>/dev/null | grep '
    unzip_search_command+=$find_pattern
    unzip_search_command+='); [ -n "$files" ] && { echo "$jar"; echo "$files" | awk "{print \"  - \" \$4}"; echo; } '
    fd -Hi "$jar_pattern" $dir  -p -x  sh -c "$unzip_search_command"
}

fzfp () {
        fzf \
          --preview='bat -f {}' \
          --height='100' \
          --preview-window='right,66%' \
          --keep-right \
          --reverse \
          --bind 'enter:execute(bat {})' \
          --bind 'shift-up:preview-page-up,shift-down:preview-page-down' \
          --biund
          --header="Enter: Preview"
}

fzfg () {
        local pattern
        if [[ -n "$1" ]]
        then
                pattern="$1"
                shift
        fi
        local ag_option=$@
        local AG_PREFIX="ag --smart-case -C0 --color ${ag_option[@]}"
        echo | fzf --ansi --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview '[[ -z {} ]] || bat --color=always {1} --highlight-line {2}' \
            --preview-window 'right,70%,border-bottom,+{2}+3/3,~3' \
            --height=100% --keep-right --with-nth=1,2 \
            --prompt="Search: " \
            --bind "change:reload:$AG_PREFIX {q} || true" \
            --ansi --disabled --query "$pattern"
}

function tpane() {
    tmux send -t+1 C-c q C-c C-m "$(echo $@)" C-m
}

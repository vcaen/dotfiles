# SOME MOre ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..="cd .."
alias ...="cd ../.."

alias cdid="cd \$STUDIO_BASE/tools/idea/"
alias cddis="cd \$STUDIO_BASE/tools/adt/idea/"
alias cdbase="cd \$STUDIO_BASE/tools/base"

# REPO
# Login if needed and Sync the current projec
alias rs="git credential-corpsso check > /dev/null || glogin; repo sync -cj99 ."
# Login if needed and Sync all projects
alias rsa="git credential-corpsso check > /dev/null || glogin; repo sync -qcj${MP_J:-$(($(envproc) * 2))} "
alias rrb="repo rebase"
alias ra="repo abandon"

# GIT
alias gsso="git credential-corpsso login"
alias gcn="gitbranchnum"
alias gtmp="git add -A && git commit -m TEMP" # Create a commit named TEMP
alias gdl="git diff --color=always | less -r" # Open git diff in less with colors

# upload a draft on gerrit
alias draft="repo upload -d --no-verify --cbr ."

# upload the current branch on gerrit
alias rupcb="repo upload --cbr ."

#invoke the cdiff tool
alias cdiff="cdiff -sw140"

# LayoutLib specific commands
alias cdll="cd \$LAYOUTLIB_PROJECT"
alias benv=". \$LAYOUTLIB_BASE/build/envsetup.sh && lunch \$LUNCH-eng"
alias mm="mm -j"
alias cpll="cp \$LAYOUTLIB_OUT/layoutlib.jar \$STUDIO_LAYOUTLIB_DIR/"
alias mcp="pushd \$LAYOUTLIB_PROJECT && mm && cpll && popd"

# Reload bashrc
alias src="source ~/.zshrc"

# GREP
# greph: highlight each pattern into a its own color
function greph() {
  color=31
  declare -a  patterns
  while [[ -n $1 ]] && [[ $1 != "-"* ]] ; do
    patterns+=("$1|$")
    shift
  done

  if [[ $1 = "-" ]] ; then # Next argument is a file
    shift
  fi

    result=""
    while IFS= read line;  # IFS allows to keep whitespace when calling read.
    do
      result="$result\n$line"
    done < "${1:-/dev/stdin}"

  for pattern in "${patterns[@]}"; do
    result="$(echo -e "$result" | GREP_COLORS="mt=01;$color" grep --color=always -P "$pattern")"
    color=$((color+1))
  done
  echo -e "$result"
}

# Diff between two files with highlighting
function grepd() {
  local file1=$1; shift
  local file2=$1; shift
  local diff=$( (wdiff $file1 $file2) )
  less -fr <(echo $diff | greph $* | colordiff )
  return 0
}

function clipdiff() {
  local a="";
  local b=""
   while [ "$b" = "$a" ] ; do b="$(xclip -o -selection clip)"; sleep 1; done
   echo "Selection 1"
   a="$b"
   while [ "$a" = "$b" ] ; do a="$(xclip -o -selection clip)"; sleep 1; done
   echo "Selection 2"
   grepd <(echo "$b") <(echo "$a")

}
# Kill existing instance of Xephyr and start a new one
alias xx="{ killall Xephyr; DISPLAY=:0; (Xephyr -ac -br -noreset  -resizeable -screen 2560x1600@43 :10 &); sleep 1; DISPLAY=:10; feh --bg-center --no-xinerama ~/Documents/wallpaper/LosAngeles-Night-View.jpg; cinnamon2d --replace -d :10 & DISPLAY=:0;  } 2> /dev/null > /dev/null"

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
  kill -9 $(ps -aef | grep -v grep | grep AndroidStudio | tr -s ' ' | cut -d' ' -f2);
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
  if [[ $1 != *"://"* ]]; then
    protocol="http://"
  fi
  if [ -n "$2" ] ; then
    echo "Opening profile $2"
    profile="--profile-directory=$2"
  fi
  google-chrome --app=$(echo "$protocol$1") "$profile";
}

# Swich links to backup. Files with same prefix and with _ln and _bk suffix are
# needed
function swln() {
  if [ -e "./$1_bk" ];  then
    mv $1 "$1_ln" && mv "$1_bk" $1
  elif [ -e "./$1_ln" ]; then
    mv $1 "$1_bk" && mv "$1_ln" $1
  else
   return 1
  fi
}

# Rebase onto
function rebo {
  git rebase --onto $1 HEAD^;
}

function ergo {
  cp $1 ~/W/ergodoxez
  unzip $1
  NAME=$(basename $1)
  pushd ~/W/ergodoxez;
  make all file=$NAME;
  popd;
}

function ergb {
  pushd ~/W/ergodoxez;
  make build;
  popd;
}


function fs() {
  i3-msg fullscreen > /dev/null && $*; i3-msg fullscreen > /dev/null
}

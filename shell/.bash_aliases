# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..="cd .."
alias ...="cd ../.."

alias cdid="cd \$STUDIO_BASE/tools/idea/"
alias cddis="cd \$STUDIO_BASE/tools/adt/idea/"
alias cdbase="cd \$STUDIO_BASE/tools/base"
alias gsso="git credential-corpsso login"
# Login if needed and Sync the current projec
alias rs="git credential-corpsso check > /dev/null || glogin; repo sync -cj64 ."
# Login if needed and Sync all projects
alias rsa="git credential-corpsso check > /dev/null || glogin; repo sync -cj64 "
alias rrb="repo rebase"
alias ra="repo abandon"
alias gcn="gitbranchnum"

# upload a draft on gerrit
alias draft="repo upload -d --no-verify --cbr ."

# upload the current branch on gerrit
alias rupcb="repo upload --cbr ."

#invoke the cdiff tool
alias cdiff="cdiff -sw140"

# LayoutLib specific commands
alias cdll="cd \$LAYOUTLIB_PROJECT"
alias benv=". \$LAYOUTLIB_BASE/build/envsetup.sh && lunch \$LUNCH-eng"
alias mm="mm -j30"
alias cpll="cp \$LAYOUTLIB_OUT/layoutlib.jar \$STUDIO_LAYOUTLIB_DIR/"
alias mcp="pushd \$LAYOUTLIB_PROJECT && mm && cpll && popd"

# Reload bashrc
alias src="source ~/.bashrc"

# Kill existing instance of Xephyr and start a new one
alias xx="{ killall Xephyr; DISPLAY=:0; (Xephyr -ac -br -noreset  -resizeable -screen 2560x1600@43 :10 &); sleep 1; DISPLAY=:10; feh --bg-center --no-xinerama ~/Documents/wallpaper/LosAngeles-Night-View.jpg; cinnamon2d --replace -d :10 & DISPLAY=:0;  } 2> /dev/null > /dev/null"

# Start a new instance of Xephyr with a 4K resolution
alias x4k="(Xephyr -ac -br -noreset -nolock -dpi 230 -screen 3838x2140 :10 & metacity --replace -d=:10 &) >/dev/null 2>&1"
alias ii="ibus-daemon -rd"
alias 4k="xrandr   -d :0  --fb  3840x2160    --output    default"
alias hd="xrandr   -d :0  --fb  2560x1600    --output    default"

alias wallpaper="feh --bg-scale --no-xinerama ~/Documents/wallpaper/8k-mountain.jpg"


alias bazel="\$STUDIO_BASE/tools/base/bazel/bazel"
# Functions
function killstudio () {
  kill -9 $(ps -aef | grep -v grep | grep AndroidStudio | tr -s ' ' | cut -d' ' -f2);
}

# Open the url given as a parameter as a standalone window of Google Chrome
function app () {
  google-chrome --app=$(echo "$1");
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



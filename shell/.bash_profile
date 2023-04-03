export PATH=~/bin:$PATH

export PS1="\[\033[0m\] \[\033[1;34m\]\u\[\033[0m\]:\[\033[1;32m\]\w\[\033[0m\]$ "

export DOTFILE_DIR="$(cd $(dirname $(readlink -f ~/.bash_profile)) && cd .. && pwd)"

echo "Dotfile directory: $DOTFILE_DIR"
source  "$DOTFILE_DIR/git/util.sh"

# Android specific
if [ -f ~/.android_env ]; then
      . ~/.android_env
fi


# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases_mac ]; then
    . ~/.bash_aliases_mac
fi

export PATH=$PATH:$DOTFILE_DIR/android
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="240x1400,3840x2560"


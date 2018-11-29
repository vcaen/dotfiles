export PATH=~/bin:$PATH

export PS1="\[\033[0m\] \[\033[1;34m\]\u\[\033[0m\]:\[\033[1;32m\]\w\[\033[0m\]$ "

# Android specific
#     LayoutLib
if [ -f ~/.android_env ]; then
      . ~/.android_env
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases_mac ]; then
    . ~/.bash_aliases_mac
fi
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="240x1400,3840x2560"

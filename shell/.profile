#!/bin/bash

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Alias definitions.

# Mac specific
if [ "$(uname)" = "Darwin" ]; then
	if [ -f ~/.bash_aliases_mac ]; then
		. ~/.bash_aliases_mac
	fi
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Android
if [ -f ~/.android_env ]; then
      . ~/.android_env
fi

# cord
if [ -f ~/.dotfiles/corp/aliases ]; then
      . ~/.dotfiles/corp/aliases
fi

#PATH
export PATH=~/bin:~/Android/Sdk/platform-tools:$PATH

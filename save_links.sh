#!/bin/zsh
# set -x
TARGET_FILE=".dotfiles/setup_links.sh"

links=$(find ~ -maxdepth 4 -type l -printf "mkdir -p %h && ln -is %l %p\n"\
    | grep dotfiles\
    | sed -s "s#$HOME#~#gi;s#\(?= \)[/~]?dotfiles/#$DIR/#gi;s/mkdir -p ~ && //gi"\
    | sort -t' ' -k 1r,3)

echo $links
if read -q "choice?Save to $TARGET_FILE? "; then
    echo "$links" > $TARGET_FILE;
else
    echo "Not saved"
fi

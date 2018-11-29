#!/bin/bash

FILES=(
    "git/.gitconfig:~/",
    "i3/config:~/.config/i3/",
    "i3/.conkyrc:~/"
)

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

for config in "${FILES[@]}" ; do
    SOURCE="$SCRIPTPATH/${config%%:*}"
    TARGET="${config#*:}"
    echo "ln -s $SOURCE $(basename $SOURCE)"
done
  

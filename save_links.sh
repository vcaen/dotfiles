#!/bin/zsh
#set -x
TARGET_FILE="$HOME/.dotfiles/setup_links.sh"

# Find all symlink in home dir, skip the dotfiles dir,  print:  (containing dir %h) (link_target $l) (link_name %p)
links=$(find ~ -maxdepth 4 -name '*dotfiles*' -prune -o -type l -printf "%h %l %p\n")

# Only keep the links pointing to a dotfiles dir
links=$(echo $links | grep dotfiles)

# Replace ~ with $HOME
links=$(echo $links | sed -s "s#$HOME#~#gi")

# Sort and ensure unicity
links=$(echo $links  | sort -t' ' -k 1r,3 | uniq)

# Create the mkdir command for all dir except the home directory (no need to build ourself a home)
dir=$(echo $links | awk '{print$1}' | grep -vE "^~$" | uniq | sort | awk '$0="mkdir -p "$0')

# Create the ln commands for all links
ln_commands=$(echo $links | awk '{print "ln -is "$2 " " $3}' | uniq | sort)

out="# Directories:\n$dir\n# Links:\n$ln_commands"
echo $out
if read -q "choice?Save to $TARGET_FILE? "; then
    echo "$out" > $TARGET_FILE;
else
    echo "Not saved"
fi

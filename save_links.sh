#!/bin/zsh
#set -x
TARGET_FILE="$HOME/.dotfiles/setup_links.sh"
TARGET_FILE_CORP="$HOME/.dotfiles/corp/setup_links.sh"

# Find all symlink in home dir, skip the dotfiles dir,  print:  (containing dir %h) (link_target $l) (link_name %p)
links=$(find ~ -maxdepth 4 -name '*dotfiles*' -prune -o -type l -printf "%h %l %p\n")

# Only keep the links pointing to a dotfiles dir
links=$(echo $links | grep dotfiles)

# Replace ~ with $HOME
links=$(echo $links | sed -s "s#$HOME#~#gi")

# Sort and ensure unicity
links=$(echo $links  | sort -t' ' -k 1r,3 | uniq)

if [[ -n $DEBUG ]] {
    echo $links
}

# Create the mkdir command for all dir except the home directory (no need to build ourself a home)
dir=$(echo $links | grep -v corp | awk '{print$1}' | grep -vE "^~$" | uniq | sort | awk '$0="mkdir -p "$0')
dir_corp=$(echo $links | grep corp | awk '{print$1}' | grep -vE "(^~$)" | uniq | sort | awk '$0="mkdir -p "$0" #corp"')

dir="$dir\n$dir_corp"

# Create the ln commands for all links
ln_commands=$(echo $links | awk '{print "ln -is "$2 " " $3}' | uniq | sort)

out="# Directories:\n$dir\n# Links:\n$ln_commands"

out_corp=$( echo "$out" | grep corp )
out=$( echo "$out" | grep -v corp )

echo "Corp links:"
echo $out_corp
if read -q "choice?Save to $TARGET_FILE_CORP? "; then
    echo "$out_corp" > $TARGET_FILE_CORP;
    out="$out\nzsh ~/.dotfiles/corp/setup_links.sh";
else
    echo "\nNot saved"
fi

echo
echo $out
if read -q "choice?Save to $TARGET_FILE? "; then
    echo "$out" > $TARGET_FILE;
else
    echo "\nNot saved"
fi

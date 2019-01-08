#!/bin/bash

git config --global alias.reball '! gitrebase'
git config --global alias.con '! gitbranchnum'

function gitrebase() {
  CURRENT=$(git rev-parse --abbrev-ref HEAD)
  for branch in $(git for-each-ref --format='%(refname:strip=-1)' refs/heads/); do
    echo "Branch $branch"
    revs=$(git rev-list $branch..$1)
    if [ -n "$revs" ]; then
      echo -e -n "\e[92mRebase? [y/n]\e[39m "
      read -n 1
      if [[ $REPLY =~ ^[Yy]$ ]]
      then
        git checkout $branch
        repo rebase . >> /dev/null
        if [[ $? != 0 ]]; then
          echo -e "\e[91mConflict with $branch, aborting\e[39m"
          git rebase --abort
        fi
      fi
    fi
    echo
  done
  git checkout $CURRENT
}

# Display the branches available prefixed with the linenumber in the output
# and prompt the user to enter the line number corresponding to the
# branch they want to switch to.
function gitbranchnum() {
  BRANCHES=$(git branch --sort=-committerdate -v)
  echo "$BRANCHES" | nl
  read -p "Switch to branch: "
  NEWBRANCH=$(echo "$BRANCHES" | sed "${REPLY}q;d" | tr -s ' ' | cut -d' ' -f2)
  git checkout $NEWBRANCH
}

export -f gitrebase
export -f gitbranchnum

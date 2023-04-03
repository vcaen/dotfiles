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
  read "REPLY?Switch to branch: "
  NEWBRANCH=$(echo "$BRANCHES" | sed "${REPLY}q;d" | tr -s ' ' | cut -d' ' -f2)
  git checkout $NEWBRANCH
}

function rdl() {
  local GERRIT_URL="https://googleplex-android-review.git.corp.google.com/changes/"
  local changeId=$(gob-curl  ${GERRIT_URL}/$(git log --format=%B -n 1 HEAD |\
    grep Change-Id |\
    awk '{print$2}') |\
    grep _number |\
    awk '{print substr($2, 1, length($2) -1)}')

 local options=$( while [[ $1 = -* ]] ; do echo $1; shift; done)
 repo download ${options} ${changeId}
 }


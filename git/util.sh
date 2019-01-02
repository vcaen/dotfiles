#!/bin/bash

function rebase() {
    for branch in $(git for-each-ref --format='%(refname:strip=-1)' refs/heads/); do
      echo "Branch $branch"
      echo
      revs=$(git rev-list $branch..$1)
      if [ -n "$revs" ]; then
        read -p "Rebase $branch? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
          git checkout $branch
          repo rebase . >> /dev/null
          if [[ $? != 0 ]]; then
            echo "Conflict with $branch, aborting"
            git rebase --abort
          fi
        fi
        echo \n
      fi
    done
}

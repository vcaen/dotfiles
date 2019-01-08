#!/bin/bash

DIR=$(dirname "$(realpath $0)")

if [ ! -f ~/.bash_profile ]; then
  ln -s $DIR/shell/.bash_profile ~/.bash_profile
fi

if [ ! -f ~/.bashrc ]; then
  ln -s $DIR/shell/.bashrc ~/.bashrc
fi

if [ ! -f ~/.gitconfig ]; then
  ln -s $DIR/git/.gitconfig ~/.gitconfig
fi

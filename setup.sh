#!/bin/bash

DIR=$(dirname "$(realpath $0)")
CONF_DIR=~/.config

if [ ! -f ~/.bash_profile ]; then
  ln -s $DIR/shell/.bash_profile ~/.bash_profile
fi

if [ ! -f ~/.bash_aliases ]; then
  ln -s $DIR/shell/.bash_aliases ~/.bash_aliases
fi

if [ ! -f ~/.bashrc ]; then
  ln -s $DIR/shell/.bashrc ~/.bashrc
fi

if [ ! -f ~/.gitconfig ]; then
  ln -s $DIR/git/.gitconfig ~/.gitconfig
fi

if [ ! -f ~/.conkyrc ]; then
  ln -s $DIR/i3/.conkyrc ~/.conkyrc
fi

if [ ! -f ~/.config/i3/config ]; then
  ln -s $DIR/i3/config $CONF_DIR/i3/config
fi

if [ ! -f ~/.profile ]; then
  ln -s $DIR/shell/.profile ~/.profile
fi

if [ ! -f ~/.zshrc ]; then
  ln -s $DIR/shell/.zshrc ~/.zshrc
fi

KITTY=$CONF_DIR/kitty
mkdir -p $KITTY
ln -s $DIR/kitty/kitty.conf $KITTY/kitty.conf
ln -s $DIR/kitty/colors.conf $KITTY/colors.conf
ln -s $DIR/kitty/diff.conf $KITTY/diff.conf

ln -s $DIR/mygitignore.txt ~/.personal_gitignore

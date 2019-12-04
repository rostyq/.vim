#!/bin/sh
SCRIPT=$(dirname "$0")

echo 'Configuring vim script'
echo 'Getting vundle'
git clone https://github.com/gmarik/vundle.git $SCRIPT/bundle/Vundle.vim

echo 'Making link for `.vimrc`'
ln -s $SCRIPT/.vimrc $HOME/.vimrc

echo 'Making link for `.ctags`'
ln -s $SCRIPT/.ctags $HOME/.ctags

echo 'Making link for `.gitignore_global`'
ln -s $SCRIPT/.gitignore_global $HOME/.gitignore_global

echo 'Creating vim directories'
mkdir $SCRIPT/.backup
mkdir $SCRIPT/.swap
mkdir $SCRIPT/.undo
mkdir $SCRIPT/view

echo 'Run vim to install all plugins'
vim +PluginInstall +qall
echo 'Done.'


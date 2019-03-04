#!/bin/sh
echo 'Configuring vim script'
echo 'Getting vundle'
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/Vundle.vim

echo 'Making link for `.vimrc`'
ln -s $HOME/.vim/.vimrc $HOME/.vimrc

echo 'Making link for `.ctags`'
ln -s $HOME/.vim/.ctags $HOME/.ctags

echo 'Making link for `.gitignore_global`'
ln -s $HOME/.vim/.gitignore_global $HOME/.gitignore_global

echo 'Run vim to install all plugins'
vim +PluginInstall +qall
echo 'Done.'


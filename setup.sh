#!/bin/sh
echo 'Configuring vim script'
echo 'Getting vundle'
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/Vundle.vim

echo 'Making link for `.vimrc`'
ln -s $HOME/.vim/.vimrc $HOME/.vimrc

echo 'Run vim to install all plugins'
vim +PluginInstall +qall
echo 'Done.'


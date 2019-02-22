echo off
echo Configuring vim script
echo Getting vundle
git clone https://github.com/gmarik/vundle.git %USERPROFILE%\.vim\bundle\Vundle.vim

echo 'Making link for `.vimrc`'
mklink %USERPROFILE%\_vimrc %USERPROFILE%\.vim\.vimrc 
mklink /D %USERPROFILE%\vimfiles %USERPROFILE%\.vim 

echo Run vim to install all plugins
vim +PluginInstall +qall
echo Done.
PAUSE

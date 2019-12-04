NAME='0cef8205-ubuntu-font-family-0.83'

echo "Downloading $NAME"
wget "https://assets.ubuntu.com/v1/$NAME.zip" -O "$NAME.zip"

echo "unzip $NAME"
unzip -j "$NAME.zip" -d $NAME

echo "install $NAME fonts"
cd $NAME
mv *.ttf "$HOME/Library/Fonts/" 
cd ../

rm "$NAME.zip"
rm -rf $NAME

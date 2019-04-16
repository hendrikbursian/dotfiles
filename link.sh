DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -fs $DIR/gitconfig ~/.gitconfig
ln -fs $DIR/gitignore ~/.gitignore
ln -fs $DIR/vimrc ~/.vimrc
ln -fs $DIR/zsh_custom ~/.zsh_custom
ln -fs $DIR/zshrc ~/.zshrc

echo "Done"

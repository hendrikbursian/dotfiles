DIR=$(dirname $(readlink -f "$0"))

find -L ~ -maxdepth 1 -type l -delete

ln -fvs "$DIR/gitconfig" "$HOME/.gitconfig"
ln -fvs "$DIR/gitignore" "$HOME/.gitignore"
ln -fvs "$DIR/vimrc" "$HOME/.vimrc"
ln -fvs "$DIR/zsh_custom" "$HOME/.zsh_custom"
ln -fvs "$DIR/zshrc" "$HOME/.zshrc"
ln -fvs "$DIR/solarized" "$HOME/.solarized"
ln -fvs "$DIR/dir_colors" "$HOME/.dir_colors"
ln -fvs "$DIR/VSCode/settings.json" "$HOME/.config/Code/User/settings.json"
ln -fvs "$DIR/VSCode/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
ln -fvs "$DIR/VSCode/snippets" "$HOME/.config/Code/User/snippets"
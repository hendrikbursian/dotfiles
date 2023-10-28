wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod +x nvim.appimage
sudo mv --verbose nvim.appimage /usr/local/bin/nvim

/usr/local/bin/nvim --version

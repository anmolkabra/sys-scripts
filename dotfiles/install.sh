#!/usr/bin/env bash

SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo "================================="
echo "WARNING: This script will erase local .vimrc, .tmux*"
echo "Remember to back up those configs"
echo "================================="

echo "\nInstalling all dotfiles except .bashrc into the home dir..."

echo "Removing vim and tmux configs..."
rm ~/.vimrc
rm -rf ~/.tmux
rm ~/.tmux.conf
rm ~/.tmux-powerlinerc

echo "Creating symlinks for .vimrc, .tmux*..."
cd
ln -s $SOURCE_DIR/.vimrc
ln -s $SOURCE_DIR/.tmux
ln -s $SOURCE_DIR/.tmux.conf
ln -s $SOURCE_DIR/.tmux-powerlinerc

echo "Getting latest Vundle for vim..."
cd
if [ -d .vim ]; then
    sudo chown $USER .vim
else
    mkdir -p .vim/bundle
fi
cd .vim/bundle
git clone --recursive https://github.com/VundleVim/Vundle.vim.git

echo "Getting latest tmux plugins..."
cd
cd .tmux
git submodule update --init

echo "Installing fonts-powerline"
sudo apt-get update
sudo apt-get install fonts-powerline

echo "Done!"
echo "Now open vim and run :PluginInstall, then go to ~/.vim/bundle/YouCompleteMe and run ./install.py --clang-completer"
echo "For tmux configs, open tmux and run prefix + C-U"

echo "You can use ${SOURCE_DIR}/.bashrc as your bashrc using:"
echo "\t$ cd; ln -s ${SOURCE_DIR}/.bashrc"

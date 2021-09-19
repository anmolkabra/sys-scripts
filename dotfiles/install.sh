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
ln -s $SOURCE_DIR/.bash_aliases
ln -s $SOURCE_DIR/.vimrc
ln -s $SOURCE_DIR/.tmux
ln -s $SOURCE_DIR/.tmux.conf
ln -s $SOURCE_DIR/.tmux-powerlinerc

echo "Installing Pathogen for vim..."
git clone --depth=1 git@github.com:amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cd ~/.vim_runtime
ln -s $SOURCE_DIR/my_configs.vim

echo "Getting latest tmux plugins..."
cd
cd .tmux
git submodule update --init --recursive

echo "Installing fonts-powerline"
sudo apt-get update
sudo apt-get install fonts-powerline

echo "Done!"
echo "Now go to ~/.vim_runtime/my_plugins/ and clone vim plugins"
echo "For tmux configs, open tmux and run prefix + C-U"

echo "You can use ${SOURCE_DIR}/.bashrc as your bashrc using:"
echo "\t$ cd; ln -s ${SOURCE_DIR}/.bashrc"

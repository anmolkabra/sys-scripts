#!/usr/bin/env bash

# Sets up useful commands using homebrew: 
brew install htop tmux vim wget

# TeX install
brew install --cask basictex
eval "$(/usr/libexec/path_helper)"
sudo tlmgr update --self
sudo tlmgr install \
    enumitem \
    fontspec \
    framed \
    tabulary \
    texliveonfly \
    titlesec \
    textpos \
    xparse \

# For website dev
brew install imagemagick
brew install chruby ruby-install xz
ruby-install ruby 3.1.3
echo "source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh" >> ~/.bash_profile
echo "source $(brew --prefix)/opt/chruby/share/chruby/auto.sh" >> ~/.bash_profile
echo "chruby ruby-3.1.3" >> ~/.bash_profile
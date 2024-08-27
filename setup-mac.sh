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
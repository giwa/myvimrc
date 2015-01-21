#!/bin/bash

# Get script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp $DIR/vimrc ~/.vimrc

# Create directory for vim bundle
if [ ! -d ~/.vim/bundle]; then
    mkdir -p ~/.vim/bundle
fi

if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
    # Clone neobundle
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

if [ ! -f ~/.vim/colors/solarized.vim ]; then
    # Clone solarized
    git clone https://github.com/altercation/vim-colors-solarized.git /tmp/solarized
    cp -rf /tmp/solarized/colors/solarized.vim ~/.vim/colors/
    rm -rf /tmp/solarized
fi

#!/bin/bash

# Get script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "$DIR/vimrc ~/.vimrc"

# Create directory for vim bundle
mkdir -p ~/.vim/bundle

# Clone neobundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# Clone solarized
git clone https://github.com/altercation/vim-colors-solarized.git /tmp/solarized
cp -rf /tmp/solarized/colors ./.vim/
rm -rf /tmp/solarized


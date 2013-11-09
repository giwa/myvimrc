import os
# vim repository
# https://github.com/giwa/myvimrc.git

git_clone_command = 'git clone '
neo_bundle_git = 'git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim'
molokai_git = 'https://github.com/tomasr/molokai /tmp/molokai'

command = 'mkdir -p ~/.vim/bundle'
os.system(command)

command = git_clone_command + neo_bundle_git
os.system(command)

command = git_clone_command + molokai_git
os.system(command)

command = 'cp -rf /tmp/molokai/colors ~/.vim/'
os.system(command)

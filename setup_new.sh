#!/bin/bash
workingdir=$(pwd)
echo "source-file $workingdir/dotfiles/tmux.conf" >> ~/.tmux.conf
echo "source-file $workingdir/dotfiles/tmux.remote.conf" >> ~/.tmux.remote.conf
echo "so $workingdir/dotfiles/vimrc" >> ~/.vimrc
echo "source $workingdir/dotfiles/bashrc" >> ~/.bashrc
echo "\$include $workingdir/dotfiles/inputrc" >> ~/.inputrc
echo "source $workingdir/dotfiles/bash_aliases" >> ~/.bash_aliases
echo "source $workingdir/dotfiles/zshrc" >> ~/.zshrc

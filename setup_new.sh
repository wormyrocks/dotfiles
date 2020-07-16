#!/bin/bash

mkdir -p .meta

PACKAGES="vim zsh tmux ripgrep screen wget curl"

prompt() {
	read -p $1 " (y/n)"
	case $yn in
		[Yy]* ) return 0;;
		[Nn]* ) return 1;;
		* ) echo "y/n":;
	esac
}

reset_meta(){
	rm .meta
}

install_dotfiles(){
	workingdir=$(pwd)
	diff .meta/workingdir $workingdir >/dev/null || {
		prompt "Looks like dotfiles are already installed. Reinstall them?" && return 0
	}
	pwd > .meta/workingdir
	echo "source-file $workingdir/dotfiles/tmux.conf" >> ~/.tmux.conf
	echo "so $workingdir/dotfiles/vimrc" >> ~/.vimrc
	echo "source $workingdir/dotfiles/bashrc" >> ~/.bashrc
	echo "source $workingdir/dotfiles/zshrc" >> ~/.zshrc
	echo "Dotfiles installed."
}

update_and_install(){
	[[ -e .meta/init_update_done ]] {
		prompt "Looks like this system has already been updated for the first time. Update again anyways?" && return 0
	}
	command -v apt >/dev/null || {
		sudo apt update && return 1
		sudo apt upgrade && return 1
		sudo apt install $PACKAGES
	} && command -v pacman >/dev/null || {
		sudo pacman -Syu && return 1
		sudo pacman -S $PACKAGES && return 1
	} && command -v dnf >/dev/null || {
		sudo dnf upgrade --refresh && return 1
		sudo dnf install $PACKAGES && return 1
	} && command -v yum >/dev/null || {
		sudo yum update && return 1
		sudo yum install $PACKAGES && return 1
	}
	touch .meta/init_update_done
	echo "System updated."
}

update_and_install || install_dotfiles

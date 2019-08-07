nvim_setup:
	mkdir -p ~/.config/nvim
	ln -sb $(PWD)/link/nvim/vimrc ~/.config/nvim/init.vim
	ln -sb $(PWD)/link/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

dotfiles_setup:
	ln -sb $(PWD)/source/ ~/.bash_source
	ln -sb $(PWD)/link/common/bash_profile ~/.bash_profile
	ln -sb $(PWD)/link/common/bashrc ~/.bashrc
	ln -sb $(PWD)/link/common/gitconfig ~/.gitconfig
	ln -sb $(PWD)/link/common/gitignore ~/.gitignore
	ln -sb $(PWD)/link/common/inputrc ~/.inputrc
	ln -sb $(PWD)/link/common/tmux.conf ~/.tmux.conf

setup: nvim_setup dotfiles_setup

install:
	ansible-playbook install.yml -i local -v -K

ansible_install_ubuntu:
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible

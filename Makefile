nvim_setup:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/link/nvim/vimrc ~/.config/nvim/init.vim
	ln -s $(PWD)/link/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

spacemacs_setup:
	ln -s $(PWD)/link/spacemacs.d ~/.spacemacs.d

dotfiles_setup:
	ln -s $(PWD)/source/ ~/.bash_source
	ln -s $(PWD)/link/common/bash_profile ~/.bash_profile
	ln -s $(PWD)/link/common/bashrc ~/.bashrc
	ln -s $(PWD)/link/common/gitconfig ~/.gitconfig
	ln -s $(PWD)/link/common/gitignore ~/.gitignore
	ln -s $(PWD)/link/common/inputrc ~/.inputrc
	ln -s $(PWD)/link/common/tmux.conf ~/.tmux.conf

setup: nvim_setup dotfiles_setup

install:
	ansible-playbook install.yml -i local -v -K

ansible_install_ubuntu:
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible

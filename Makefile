dotfiles:
	ansible-playbook dotfiles.yml -i local -v
install:
	ansible-playbook install.yml -i local -v -K
nvim:
	ansible-playbook nvim.yml -i local --skip-tags php -v -K
all:
	make dotfiles
	make install
	make nvim
ansible_install_ubuntu:
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible

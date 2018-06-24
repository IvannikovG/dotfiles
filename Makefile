dotfiles:
	ansible-playbook dotfiles.yml -i local -v
nvim:
	ansible-playbook install.yml -i local -v -K
nvim:
	ansible-playbook nvim.yml -i local --skip-tags php -v
ansible_install_ubuntu:
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible

dotfiles:
	ansible-playbook dotfiles.yml -i local -v

dotfilesp3:
	ansible-playbook dotfiles.yml -i localp3 -v

ansible_install_ubuntu:
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible

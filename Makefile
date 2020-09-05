nvim_setup:
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/link/nvim/vimrc ~/.config/nvim/init.vim
	ln -s $(PWD)/link/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

spacemacs_setup:
	ln -s $(PWD)/link/spacemacs.d ~/.spacemacs.d

doom_setup:
	ln -s $(PWD)/link/doom.d ~/.doom.d

doom_packages_setup:
	npm i -g bash-language-server
	npm i -g typescript-language-server

dotfiles_setup:
	tic -x -o ~/.terminfo scripts/xterm-24bit.terminfo
	ln -sf $(PWD)/source/ ~/.bash_source
	ln -sf $(PWD)/link/common/bash_profile ~/.bash_profile
	ln -sf $(PWD)/link/common/bashrc ~/.bashrc
	ln -sf $(PWD)/link/common/gitconfig ~/.gitconfig
	ln -sf $(PWD)/link/common/gitignore ~/.gitignore
	ln -sf $(PWD)/link/common/inputrc ~/.inputrc
	ln -sf $(PWD)/link/common/tmux.conf ~/.tmux.conf

# setup: nvim_setup dotfiles_setup

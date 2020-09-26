.DEFAULT_GOAL := help

.PHONY: all
all: backup remove link-all ## backup → remove → link-all

.PHONY: backup
backup: ## Backup bashrc, vimrc, zshrc
	@if [ -f $$HOME/.bashrc ] ; then\
		echo "bashrc is exist";\
		echo "cp bashrc";\
		cp -pi $$HOME/.bashrc $$HOME/.dotfiles/backup/bashrc.`date +"%Y%m%d%H%M%S"`;\
	fi
	@if [ -f $$HOME/.zshrc ] ; then\
		echo "zshrc is exist";\
		echo "cp zshrc";\
		cp -pi $$HOME/.zshrc $$HOME/.dotfiles/backup/zshrc.`date +"%Y%m%d%H%M%S"`;\
	fi
	@if [ -f $$HOME/.vimrc ] ; then\
		echo "vimrc is exist";\
		echo "cp vimrc";\
		cp -pi $$HOME/.vimrc $$HOME/.dotfiles/backup/vimrc.`date +"%Y%m%d%H%M%S"`;\
	fi
	@if [ -d $$HOME/.vim/ ] ; then\
		echo "vim dir is exist";\
		echo "cp vimdir";\
		cp -a $$HOME/.vim/ $$HOME/.dotfiles/backup/vim.`date +"%Y%m%d%H%M%S"`;\
	fi
	@if [ -f $$HOME/.tmux.conf ] ; then\
		echo "tmux.conf is exist";\
		echo "cp tmux.conf";\
		cp -pi $$HOME/.tmux.conf $$HOME/.dotfiles/backup/tmux.conf.`date +"%Y%m%d%H%M%S"`;\
	fi
	@if [ -f $$HOME/.gitconfig ] ; then\
		echo "gitconfig is exist";\
		echo "cp gitconfig";\
		cp -pi $$HOME/.gitconfig $$HOME/.dotfiles/backup/gitconfig.`date +"%Y%m%d%H%M%S"`;\
	fi

.PHONY: remove
remove: ## Remove bashrc, vimrc, zshrc
	@echo "remove bashrc"
	@rm $$HOME/.bashrc
	@echo "remove zshrc"
	@rm $$HOME/.zshrc
	@echo "remove vimrc"
	@rm $$HOME/.vimrc
	@echo "remove vim"
	@rm -rf $$HOME/.vim/
	@echo "remove tmux.conf"
	@rm $$HOME/.tmux.conf
	@echo "remove gitconfig"
	@rm $$HOME/.gitconfig

.PHONY: link-all
link-all: ## create symbolick link all files
	@echo "link vimrc"
	@ln -sf $$HOME/.dotfiles/vimrc $$HOME/.vimrc
	@echo "link vim dir"
	@ln -nsf $$HOME/.dotfiles/vim $$HOME/.vim
	@echo "link bashrc"
	@ln -sf $$HOME/.dotfiles/bashrc $$HOME/.bashrc
	@echo "link zshrc"
	@ln -sf $$HOME/.dotfiles/zshrc $$HOME/.zshrc
	@echo "link tmux.conf"
	@ln -sf $$HOME/.dotfiles/tmux.conf $$HOME/.tmux.conf
	@echo "link gitconfig"
	@ln -sf $$HOME/.dotfiles/gitconfig $$HOME/.gitconfig

.PHONY: link-vim
link-vim: ## create symbolick link all files
	@echo "link vimrc"
	@ln -sf $$HOME/.dotfiles/vimrc $$HOME/.vimrc
	@echo "link vim dir"
	@ln -nsf $HOME/.dotfiles/vim $$HOME/.vim

.PHONY: help
help: ## Display this help messages
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

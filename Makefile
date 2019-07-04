.DEFAULT_GOAL := help
DOTFILES_DIR := ~/.ghq/github.com/makotoeeee/dotfiles
REPO_URL := https://github.com/makotoeeee/dotfiles
ILOG = $(shell echo $$(date +'%FT%T') [info])
OS :=$(shell uname)

.PHONY: install prepare run-ansible-playbook destroy clean install-homebrew install-ansible help logstart logfinished

install: logstart prepare run-ansible-playbook logfinished ## Clone the dotfiles repository, Install homebrew and Ansible. Then run ansible-playbook.

prepare: clone install-homebrew install-ansible ## Clone the dotfiles repository, Install homebrew and Ansible.

logstart:
	@echo "$(ILOG) Starting......"

logfinished:
	@echo "$(ILOG) Finished!"

clone: ## Clone dotfiles repository
	@echo "$(ILOG) start clone dotfiles repository"
	@if [ ! -d $(DOTFILES_DIR) ]; then\
		git clone $(REPO_URL) $(DOTFILES_DIR);\
		echo "$(ILOG) Finish cloning dotfiles repository";\
		exit 0;\
	fi;\
	echo "$(ILOG) dotfiles repository already exists"

run-ansible-playbook: ## Execute ansible playbook
	@echo "$(ILOG) Run ansible-playbook"
	@ansible-playbook -i hosts localhost.yml
	@echo "$(ILOG) Finished ansible-playbook"

destroy: ## Uninstall homebrew, Command Line Tools for Xcode.
	@bash $(DOTFILES_DIR)/scripts/$(OS)/uninstall-homebrew.sh
	@bash $(DOTFILES_DIR)/scripts/$(OS)/uninstall-command-line-tools-for-Xcode.sh

clean: ## Delete localhost.retry
	rm -f localhost.retry

install-homebrew: ## Install homebrew
	@bash $(DOTFILES_DIR)/scripts/$(OS)/install-homebrew.sh

install-ansible: ## Install Ansible
	@bash $(DOTFILES_DIR)/scripts/$(OS)/install-ansible.sh

test-lib:
	touch test
	ls -l test*
	ansible localhost -i hosts --connection=local -m move -a src="test" --module-path=./library/
	ls -l test*
	rm test*

help: ## Display help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

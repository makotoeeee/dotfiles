.DEFAULT_GOAL := help
DOTFILES_DIR := ~/.ghq/github.com/makotoeeee/dotfiles
REPO_URL := https://github.com/makotoeeee/dotfiles
ILOG = $(shell echo $$(date +'%FT%T') [info])

.PHONY: install init run-ansible-playbook destroy clean install-homebrew install-ansible help logstart logfinished

install: logstart init run-ansible-playbook logfinished ## Clone the dotfiles repository, Install homebrew and Ansible. Then run ansible-playbook.

init: clone install-homebrew install-ansible ## Clone the dotfiles repository, Install homebrew and Ansible.

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
	@$(DOTFILES_DIR)/scripts/run-ansible-playbook.sh

destroy: ## Uninstall homebrewbrew
	@$(DOTFILES_DIR)/scripts/uninstall-homebrew.sh

clean: ## Delete localhost.retry
	rm -f localhost.retry

install-homebrew: ## Install homebrew
	@$(DOTFILES_DIR)/scripts/install-homebrew.sh

install-ansible: ## Install Ansible
	@$(DOTFILES_DIR)/scripts/install-ansible.sh

help: ## Display help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

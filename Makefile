.DEFAULT_GOAL := help
DOTFILES_DIR := ~/.ghq/github.com/makotoeeee/dotfiles
REPO_URL := https://github.com/makotoeeee/dotfiles
ILOG = $(shell echo $$(date +'%FT%T') [info])

.PHONY: install init setup destroy clean install-homebrew install-ansible help logstart logfinished

install: logstart init setup logfinished ## Clone the dotfiles repository, Install homebrew and Ansible. Then run ansible-playbook.

init: clone install-homebrew install-ansible ## Clone the dotfiles repository, Install homebrew and Ansible.

logstart:
	@echo "$(ILOG) Starting......"

logfinished:
	@echo "$(ILOG) Finished!"

clone: ## Clone dotfiles repository
	@if [ ! -d $(DOTFILES_DIR) ]; then\
       git clone $(REPO_URL) $(DOTFILES_DIR);\
       echo "$(ILOG) Finish cloning dotfiles repository";\
     fi
	@echo "$(ILOG) dotfiles repository already exists"

setup: ## Execute ansible playbook
	@./scripts/run-ansible-playbook.sh

destroy: ## Uninstall homebrewbrew
	@./scripts/uninstall-homebrew.sh

clean: ## Delete localhost.retry
	rm -f localhost.retry

install-homebrew: ## Install homebrew
	@./scripts/install-homebrew.sh

install-ansible: ## Install Ansible
	@./scripts/install-ansible.sh

help: ## Display help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

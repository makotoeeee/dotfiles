.DEFAULT_GOAL := help
DOTFILES_DIR := ~/.ghq/github.com/makotoeeee/dotfiles
REPO_URL := https://github.com/makotoeeee/dotfiles

all: init setup ## Install homebrew and ansible, then run ansible playbook

init: install-homebrew install-ansible ## Install homebrew and ansible

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

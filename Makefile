all: init setup

init: install-homebrew install-ansible

setup:
	ansible-playbook -i hosts localhost.yml

clean:
	rm -f localhost.retry

destroy: uninstall-homebrew

install-homebrew:
	./scripts/install-homebrew.sh

install-ansible:
	./scripts/install-ansible.sh

uninstall-homebrew:
	./scripts/uninstall-homebrew.sh

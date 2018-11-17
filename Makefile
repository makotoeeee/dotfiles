init:
	brew install ansible

setup:
	ansible-playbook -i hosts localhost.yml

#!/bin/bash

function ilog {
  echo "$(date  +'%FT%T') [info] $1"
}

function elog {
  echo "$(date  +'%FT%T') [error] $1"
}

install_homebrew() {
  ilog "Install homebrew"

  if test $(which brew); then
    ilog "homebrew is already installed."
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ilog "Installed homebrew"
  fi
}

install_ansible() {
  ilog "Install ansible"

  if test $(which ansible); then
    ilog "ansible is already installed."
  else
    brew install ansible
    ilog "Installed ansible"
  fi
}

install_ansible_modules() {
  ilog "Install ansible modules"

  if [ -d $HOME/.ansible ]; then
    ilog "ansible modules is already installed."
  else
    ansible-galaxy collection install community.general
    ilog "Installed ansible modules"
  fi
}

run_ansible() {
  ilog "Run ansible-playbook"
  ansible-playbook -i hosts localhost.yml
  ilog "Finished ansible-playbook"
}

install_vim-plug() {
  ilog "Install vim-plug"

  if [ -f $HOME/.vim/autoload/plug.vim ]; then
    ilog "vim-plug is already installed."
  else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ilog "Installed vim-plug"
  fi
}

main() {
  install_homebrew
  install_ansible
  install_ansible_modules
  install_vim-plug
  run_ansible
}

main

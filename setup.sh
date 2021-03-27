#!/bin/bash
set -e

is_darwin() {
  local uname=$(uname)
  if [ $uname = "Darwin" ]; then
    return 0
  else
    return 1
  fi
}

is_ubuntu() {
  local uname=$(uname)
  if [ $uname = "Linux" ]; then
    if grep ID=ubuntu /etc/os-release > /dev/null 2>&1 ; then
      return 0
    fi
  else
    return 1
  fi
}

ilog() {
  echo "$(date  +'%FT%T') [info] $1"
}

elog() {
  echo "$(date  +'%FT%T') [error] $1"
}

set_env() {
  export PATH=/opt/homebrew/bin:$PATH
}

install_homebrew() {
  ilog "Install homebrew"

  if test $(which /opt/homebrew/bin/brew); then
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
    return 0
  fi

  if is_darwin ; then
    arch -arm64 brew install ansible
    ilog "Installed ansible"
    return 0
  fi

  if is_ubuntu ; then
    sudo apt update
    sudo apt install ansible -y
    ilog "Installed ansible"
    return 0
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
  is_darwin && set_env
  is_darwin && install_homebrew
  install_ansible
  install_ansible_modules
  install_vim-plug
  run_ansible
}

main

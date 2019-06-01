#!/bin/bash
path=$(cd $(dirname $0); pwd)
source $path/../utils/log.sh

install_ansible() {
  if test ! $(which ansible); then
    brew install ansible
    ilog "Finish installing ansible"
    exit 0
  fi
}

main() {
  ilog "Start installing ansible"
  install_ansible
  ilog "ansible is already installed. Skip installing ansible"
  exit 0
}

main

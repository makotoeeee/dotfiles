#!/bin/bash
path=$(cd $(dirname $0); pwd)
source $path/../utils/log.sh

install_homebrew() {
  if test ! $(which brew); then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ilog "Finish installing homebrew"
    exit 0
  fi
}

main() {
  ilog "Start installing homebrew"
  install_homebrew
  ilog "homebrew is already installed. Skip installing homebrew"
  exit 0
}

main

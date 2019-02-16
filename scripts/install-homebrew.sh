#!/bin/bash
path=$(cd $(dirname $0); pwd)
source $path/utils.sh

ilog "Start installing homebrew"

if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  ilog "Finish installing homebrew"
  exit 0
fi

ilog "homebrew is already installed. Skip installing homebrew"
exit 0

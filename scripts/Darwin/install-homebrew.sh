#!/bin/bash
path=$(cd $(dirname $0); pwd)
source $path/../utils/log.sh

ilog "Start installing homebrew"

if test $(which brew); then
  ilog "homebrew is already installed. Skip installing homebrew"
  exit 0
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
ilog "Finish installing homebrew"
exit 0

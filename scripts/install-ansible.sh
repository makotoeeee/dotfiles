#!/bin/bash
path=$(cd $(dirname $0); pwd)
source $path/utils.sh

ilog "Start installing ansible"

if test ! $(which ansible); then
  brew install ansible
  ilog "Finish installing ansible"
fi

ilog "ansible is already installed. Skip installing ansible"
exit 0

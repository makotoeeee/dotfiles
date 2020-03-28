#!/bin/bash
path=$(cd $(dirname $0); pwd)
source $path/utils/log.sh

clone_dotfiles() {
  ilog "start clone dotfiles repository"

  if [ -d $(DOTFILES_DIR) ]; then
    ilog "dotfiles repository already exists"
    return 0
  fi

  local DOTFILES_DIR=~/.ghq/github.com/makotoeeee/dotfiles
  local REPO_URL=https://github.com/makotoeeee/dotfiles

  git clone ${REPO_URL} ${DOTFILES_DIR};
  ilog "Finish cloning dotfiles repository"
  return 0
}

main() {
  ilog "Starting......"
  clone_dotfiles
  ilog "Finished!"
}

main

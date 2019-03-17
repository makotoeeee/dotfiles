#!/bin/bash
path=$(cd $(dirname $0); pwd)
source $path/scripts/utils.sh

clone_dotfiles_repo() {
  ilog "Start cloning dotfiles repository"

  if [ ! -d $DOTFILES_DIR ]; then
    git clone $REPO_URL $DOTFILES_DIR
    ilog "Finish cloning dotfiles repository"
  fi

  ilog "dotfiles repository already exists"
}

execute_make() {
  cd $DOTFILES_DIR
  make all
}

main() {
  readonly DOTFILES_DIR=~/.ghq/github.com/makotoeeee/dotfiles
  readonly REPO_URL=https://github.com/makotoeeee/dotfiles

  ilog "Starting......"
  clone_dotfiles_repo
  execute_make
  ilog "Finished!"
}

main

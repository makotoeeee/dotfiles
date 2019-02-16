#!/bin/bash

echo "[INFO] Starting......"

readonly DOTFILES_DIR := ~/.ghq/github.com/makotoeeee/dotfiles
readonly REPO_URL := https://github.com/makotoeeee/dotfiles

if [ ! -d $DOTFILES_DIR ]; then
  git clone $REPO_URL $DOTFILES_DIR
fi

cd $DOTFILES_DIR
make all

echo "[info] Finished!"

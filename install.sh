#!/bin/bash

echo "[INFO] Starting......"

readonly DIR=~/.ghq/github.com/makotoeeee

if [ ! -d ${DIR} ]; then
  mkdir -p ${DIR}
fi

cd ${DIR}

if [ ! -n "$(ls $DIR)" ]; then
  git clone https://github.com/makotoeeee/dotfiles
fi

cd ${DIR}/dotfiles
make all

echo "[info] Finished!"

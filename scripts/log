#!/bin/bash

case "$1" in
  "i")
    echo "$(date  +'%FT%T') [info] $2"
    ;;
  "e")
    echo "$(date  +'%FT%T') [error] $2"
    ;;
  *)
    echo "Usage: log.sh i|e <messages>"
    exit 1
    ;;
esac

exit 0

#!/bin/bash

function ilog {
  echo "$(date  +'%FT%T') [info] $1"
}

function elog {
  echo "$(date  +'%FT%T') [error] $1"
}

#!/bin/bash

touch hoge 
ls -l hoge*
ansible localhost -i ../hosts --connection=local -m backup -a "src=hoge" --module-path=.
ls -l hoge*
rm hoge*

#!/bin/bash

touch hoge 
ls -l hoge*
ansible localhost -i ../hosts --connection=local -m move -a "src=hoge" --module-path=.
ls -l hoge*
rm hoge*

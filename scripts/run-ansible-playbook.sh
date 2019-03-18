#!/bin/bash
path=$(cd $(dirname $0); pwd)
source $path/utils/log.sh

ilog "Run ansible-playbook"
ansible-playbook -i $path/../hosts $path/../localhost.yml
ilog "Finished ansible-playbook"

#!/usr/bin/python

import os
import datetime
import shutil
from ansible.module_utils.basic import *

def get_argument():
    argument_spec = dict(
        src = dict(required=True)
    )

    return argument_spec

def time_stamp():
    return datetime.datetime.now().strftime('%Y%m%d%H%M%S')

def main():
    module = AnsibleModule(argument_spec=get_argument())
    src = os.path.expanduser(module.params['src'])
    dst = src + '.bk.' + time_stamp()
    changed = False

    if os.path.exists(src) and not os.path.islink(src):
        shutil.move(src, dst)
        changed = True

    module.exit_json(src=src, dst=dst, changed=changed)

if __name__ == '__main__':
    main()

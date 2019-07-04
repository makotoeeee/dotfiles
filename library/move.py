#!/usr/bin/python

import os
import datetime
import shutil
from ansible.module_utils.basic import *

def get_argument():
    argument_spec = dict(
        src = dict(required=True)
    )

    return AnsibleModule(argument_spec = argument_spec)

def main():
    module = get_argument()
    time_stamp = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
    src = os.path.abspath(module.params['src'])
    changed = False

    if os.path.exists(src):
        dst = src + '_' + time_stamp
        shutil.move(src, dst)
        changed = True

    module.exit_json(src=src, changed=changed)

if __name__ == '__main__':
    main()

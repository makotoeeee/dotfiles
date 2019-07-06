#!/usr/bin/python

import os
import datetime
import shutil
from ansible.module_utils.basic import *

class Homebrew:
    def __init__(self, module):
        self.__module = module
        self.__command = ""
        self.__changed = True
        self.__rc = 0
        self.__out = ""
        self.__err = "" 

    @property
    def changed(self):
        return self.__changed

    @property
    def rc(self):
        return self.__rc

    @property
    def out(self):
        return self.__out

    @property
    def err(self):
        return self.__err

    @property
    def command(self):
        return self.__command

    # Install Homebrew
    def latest(self):
        if not self.__module.get_bin_path('brew', False):
            self.__command = "/usr/bin/ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            self.__run_command(self.__command)
            self.__changed = True

        self.__changed = False 

    # Uninstall Homebrew
    def absent(self):
        if self.__module.get_bin_path('brew', False):
            self.__command = "ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
            self.__run_command(self.__command)
            self.__changed = True

        self.changed = False 

    def __run_command(self, command):
        self.__rc, self.__out, self.__err = self.__module.run_command(comannd)

def get_argument():
    argument_spec = dict(
        state = dict(required=True)
    )

    return argument_spec

def main():
    module = AnsibleModule(argument_spec=get_argument())
    state = module.params['state']
    homebrew = Homebrew(module)

    try:
        getattr(homebrew, state)()
    except AttributeError:
        msg = state + " is not defined."
        module.fail_json(msg=msg)

    if homebrew.rc != 0:
        msg = '{0} Failed. rc={1}, out={2}, err={3}'.format(
            homebrew.command, homebrew.rc, homebrew.out, homebrew.err
        )
        module.fail_json(msg=msg)
    
    module.exit_json(state=state, changed=homebrew.changed)

if __name__ == '__main__':
    main()

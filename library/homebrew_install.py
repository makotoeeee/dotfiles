#!/usr/bin/python

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

    def install(self):
        if not self.__module.get_bin_path('brew', False):
            self.__command = "/usr/bin/ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            self.__run_command(self.__command)
        else:
            self.__changed = False 

    def uninstall(self):
        if self.__module.get_bin_path('brew', False):
            self.__command = "ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
            self.__run_command(self.__command)
        else:
            self.changed = False 

    def __run_command(self, command):
        self.__rc, self.__out, self.__err = self.__module.run_command(comannd)
        self.__changed = True

    # Define method alias
    latest = install
    absent = uninstall

def define_module_args():
    args = dict(
        state=dict(type='str', required=True)
    )

    return args

def validate_state_value(state):
    if state in ('latest', 'absent'):
        msg = state + " is not defined."
        return True
    else:
        return False

def is_homebrew_failed(homebrew):
    if homebrew.rc is 0:
        return False
    else:
        return True

def main():
    module = AnsibleModule(argument_spec=define_module_args())
    state = module.params['state']
    homebrew = Homebrew(module)

    if not validate_state_value(state): 
        msg = state + " is not defined."
        module.fail_json(msg=msg)

    getattr(homebrew, state)()

    if is_homebrew_failed(homebrew):
        msg = '{0} Failed. rc={1}, out={2}, err={3}'.format(
            homebrew.command, homebrew.rc, homebrew.out, homebrew.err
        )
        module.fail_json(msg=msg)

    module.exit_json(state=state, changed=homebrew.changed)

if __name__ == '__main__':
    main()

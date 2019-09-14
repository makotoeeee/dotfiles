#!/usr/bin/python

from ansible.module_utils.basic import *

class Homebrew:
    def __init__(self, module):
        self._module = module
        self._command = ""
        self._changed = True
        self._rc = 0
        self._out = ""
        self._err = "" 

    @property
    def changed(self):
        return self._changed

    @property
    def rc(self):
        return self._rc

    @property
    def out(self):
        return self._out

    @property
    def err(self):
        return self._err

    @property
    def command(self):
        return self._command

    def install(self):
        if not self._module.get_bin_path('brew', False):
            self._command = "/usr/bin/ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            self._run_command(self._command)
        else:
            self._changed = False 

    def uninstall(self):
        if self._module.get_bin_path('brew', False):
            self._command = "ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
            self._run_command(self._command)
        else:
            self._changed = False 

    def is_failed(self):
        if self._rc is 0:
            return False
        else:
            return True

    def _run_command(self, command):
        self._rc, self._out, self._err = self._module.run_command(comannd)
        self._changed = True

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
        return True
    else:
        return False

def main():
    module = AnsibleModule(argument_spec=define_module_args())
    state = module.params['state']
    homebrew = Homebrew(module)

    if not validate_state_value(state): 
        msg = state + " is not defined."
        module.fail_json(msg=msg)

    getattr(homebrew, state)()

    if homebrew.is_failed():
        msg = '{0} Failed. rc={1}, out={2}, err={3}'.format(
            homebrew.command, homebrew.rc, homebrew.out, homebrew.err
        )
        module.fail_json(msg=msg)

    module.exit_json(state=state, changed=homebrew.changed)

if __name__ == '__main__':
    main()

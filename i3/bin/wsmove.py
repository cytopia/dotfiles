#!/usr/bin/env python
''' i3 helper to move windows to named workspaces'''

import sys
import subprocess
import json

def run(command):
    '''Wrapper to run shell commands'''
    return subprocess.Popen(command, shell=True, stdout=subprocess.PIPE).stdout.readlines()

def main(argv):
    '''Main entrypoint'''
    workspaces = json.loads(''.join(run('i3-msg -t get_workspaces')))

    target = argv[1]

    focused_workspace_num = None
    for workspace in workspaces:
        if workspace['focused']:
            focused_workspace_num = workspace['num']
            break

    # get all named workspaces from config
    command = 'cat ~/.config/i3/config | grep "^set \\$WS" | sed "s/.*\\$WS[0-9]*\\s//g"'
    workspace = ''.join(run(command)).split('\n')

    if target == "prev":
        if focused_workspace_num == 1:
            sendto = 10
        else:
            sendto = focused_workspace_num - 1
    elif target == "next":
        if focused_workspace_num == 10:
            sendto = 1
        else:
            sendto = focused_workspace_num + 1

    # Move container to chosen workspace
    run('i3-msg move container to workspace ' + workspace[sendto-1])
    # Jump to chosen workspace
    run('i3-msg workspace ' + workspace[sendto-1])

if __name__ == '__main__':
    main(sys.argv)

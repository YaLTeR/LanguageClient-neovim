#!/usr/bin/env python3

import subprocess
import re
import semver


def tag_to_version(tag):
    version = re.sub(r'binary-', '', tag)
    version = re.sub(r'-[x86|i686].*', '', version)
    return version


subprocess.check_call('git pull --tags', shell=True)
tags = subprocess.check_output(
    'git tag --list | grep binary', shell=True).decode('UTF-8').splitlines()
versions = sorted(list(set([tag_to_version(tag) for tag in tags])), key=semver.parse_version_info)
versions_to_delete = versions[:-3]

cmd_delete_local = 'git tag --delete'
cmd_delete_remote = 'git push --delete origin'
for tag in tags:
    if tag_to_version(tag) in versions_to_delete:
        cmd_delete_local += ' ' + tag
        cmd_delete_remote += ' ' + tag

if not cmd_delete_local.endswith('delete'):
    subprocess.check_call(cmd_delete_local, shell=True)
if not cmd_delete_remote.endswith('origin'):
    subprocess.check_call(cmd_delete_remote, shell=True)

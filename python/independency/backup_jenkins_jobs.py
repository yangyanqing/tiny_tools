#!/usr/bin/env python  
#encoding: utf-8

import os
import re

jobs_home    = "E:\Jenkins\jobs"
ignore_jobs  = (
               )

# Windows 下，svn 的多行忽略命令只能通过文件方式导入
ignore_items = '''
builds
ncover
*.log
'''

def revert_add():
    for i in os.popen('svn st | findstr "^A"').read().split("\n"):
        job_name, number = re.subn('A\s+', '', i)
        print os.popen('svn revert "%s"' % (job_name)).read()

def add_jobs():
    for i in os.popen("svn st | findstr ? | findstr -V \\").read().split("\n"):
        job, number = re.subn('\?\s+', '', i)
        if job in ignore_jobs:
            continue
        print os.popen('svn add "%s" --depth empty'           % (job)).read()
        print os.popen('svn add "%s/config.xml"'              % (job)).read()
        print os.popen('svn add "%s/nextBuildNumber"'         % (job)).read()
        print os.popen('svn add "%s/subversion.credentials"'  % (job)).read()
        print os.popen('svn add "%s/svnexternals.txt"'        % (job)).read()

def set_ignore():
    for job in os.listdir('.'):
        if job != '.svn':
            args_file = 'args.txt'
            with open(args_file, 'w') as f:
                f.write('"%s"' % (ignore_items))
            print os.popen('svn propset svn:ignore -F %s "%s"' % (args_file, job)).read()
            os.remove(args_file)

os.chdir(jobs_home)
#revert_add()
add_jobs()
set_ignore()

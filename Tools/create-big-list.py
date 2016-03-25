#!/usr/bin/env python
from tdldk import v1_0 as t
import subprocess

api_url = 'http://%s:3000' % subprocess.check_output(["docker-machine", "ip", "default"]).replace('\n', '')

session = t.SKTDLSession(username='primalmotion', password='secret', enterprise='none', api_url=api_url)
session.start()

todo_list = t.SKList(name='Big List', description='A very big list indeed')
session.root.create_child(todo_list)

for i in range(1, 201):
    task = t.SKTask(name='Task %s' % str(i).rjust(3, '0'),
                    description='A very urgent task',
                    status=t.SKTask.CONST_STATUS_TODO if not i % 2 else t.SKTask.CONST_STATUS_DONE)
    todo_list.create_child(task)

#!/usr/bin/env python
from tdldk import v1_0 as t
import subprocess

api_url = 'http://%s:3000' % subprocess.check_output(["docker-machine", "ip", "default"]).replace('\n', '')

session = t.SKTDLSession(username='primalmotion', password='secret', enterprise='none', api_url=api_url)
session.start()

for i in range(1, 201):
    location = t.SKLocation(name='Location %s' % str(i).rjust(3, '0'), address='Planet Earth')
    session.root.create_child(location)

#!/bin/env python3

# Copyright (c) 2019, Dan Sheffner Digital Imaging Software Solutions, INC
# All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish, dis-
# tribute, sublicense, and/or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the fol-
# lowing conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL-
# ITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
# SHALL THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

import json
import requests
import subprocess as sb

response = requests.get("https://summer-scene-61e0.thesheff17.workers.dev/")
json_response = response.json()

docker = json_response['docker']
services = json_response['services']
createdirectory = json_response['createdirectory']
commands = json_response['commands']
files = json_response['files']
gitrepos = json_response['gitrepos']
apt = json_response['apt']

apt2 = ["yum", "install", "-y"]
apt = apt2 + apt

if __name__ == "__main__":

    print ("start.py started...")
    sb.call(apt)

    for each in commands:
        # this is very dangerous make sure you know what is being
        # called here from your json object.
        sb.call(each, shell=True)

    for each in services:
        sb.call(["service", each, "start"])
        sb.call(["chkconfig", each, "on"])

    for each in createdirectory:
        if not os.path.exists(each):
            os.makedirs(each)
    
    for key, value in gitrepos.items():
        sb.call("cd " + value + " && git clone " + key, shell=True)

    for each in docker:
        sb.call(["docker", "pull", each])

    for key, value in files.items():
        sb.call(["wget", key], cwd=value)

    sb.call("chmod +x /root/*.sh /root/*.py", shell=True)

    print("start.py completed")

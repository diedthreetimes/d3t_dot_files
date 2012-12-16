#!/usr/bin/env python
import os
import time

valid = "ELD_Valid=1"
invalid = "ELD_Valid=0"

def executeCommand(the_command):
    temp_list = os.popen(the_command).read()
    return temp_list

def getDMESG():
    return executeCommand("dmesg | grep -i hdmi | tail -n 10")

def needsRefresh():
    list = getDMESG();
    valid_index = list.rfind(valid)
    invalid_index = list.rfind(invalid)
    if invalid_index > valid_index:
        return True
    else:
        return False

def doTest():
    if needsRefresh() == True:
        os.popen("xrandr -display :0 --output DFP5 --off; xrandr -display :0 --output DFP5 --auto").read()

while True:
    doTest()
    time.sleep(5)

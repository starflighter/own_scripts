#!/usr/bin/env python

import os

newpath = '/tmp/pandora' 
if not os.path.exists(newpath):
    os.makedirs(newpath)


os.execl("./pandora", "")




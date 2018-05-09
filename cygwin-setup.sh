#!/usr/bin/env bash

setup=setup-x86_64.exe
rm ${setup}
wget http://cygwin.com/${setup}
chmod u+x ~/${setup}
run ~/${setup} --no-admin

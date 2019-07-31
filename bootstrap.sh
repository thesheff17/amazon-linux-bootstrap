#!/bin/bash

# Copyright (c) 2015, Dan Sheffner Digital Imaging Software Solutions, INC
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

# this script will bootstrap an amazon linux box

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

SECONDS=0

# updates
yum update -y
yum upgrade -y
yum install -y \
    bzip2-devel \
    fail2ban \
    gcc \
    gdbm-devel \
    git-core.x86_64 \
    gzip \
    java-1.8.0-openjdk.x86_64 \
    libffi-devel \
    make \
    ncurses-devel \
    openssl-devel \
    python3-devel.x86_64 \
    python3-libs.x86_64 \
    python3.x86_64 \
    readline-devel \
    sqlite-devel \
    tar.x86_64 \
    tk-devel \
    tmux \
    uuid-devel \
    wget \
    xz-devel \
    zlib-devel 

# pip 
pip3 install awscli

# time elaspsed 
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."

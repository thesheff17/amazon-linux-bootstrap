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

set -ex

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
    gzip \
    libffi-devel \
    make \
    ncurses-devel \
    openssl-devel \
    readline-devel \
    sqlite-devel \
    tar.x86_64 \
    tk-devel \
    tmux \
    uuid-devel \
    wget \
    xz-devel \
    zlib-devel 

# install python
wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
tar -xf Python-3.7.4.tgz
cd Python-3.7.4/
./configure --prefix=/root/python37 --enable-shared --enable-optimizations
make -j4
make altinstall

echo "export LD_LIBRARY_PATH=/opt/python37/lib" >> /root/.bashrc 
echo "export PATH=/opt/python37/bin:$PATH" >> /root/.bashrc
echo "if [ ! -f /usr/local/bin/python3 ]; then" >>  /root/.bashrc 
echo "ln -s /opt/python37/bin/python3.7 /usr/local/bin/python3" >>  /root/.bashrc 
echo "fi" >> /root/.bashrc 
echo "if [ ! -f /usr/local/bin/pip3 ]; then" >>  /root/.bashrc 
echo "ln -s /opt/python37/bin/pip3.7 /usr/local/bin/pip3" >>  /root/.bashrc 
echo "fi" >> /root/.bashrc

echo "export LD_LIBRARY_PATH=/root/python37/lib" >> /root/.bashrc

# pip3 install
export LD_LIBRARY_PATH=/opt/python37/lib && /opt/python37/bin/pip3.7 install awscli

# time elaspsed 
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."

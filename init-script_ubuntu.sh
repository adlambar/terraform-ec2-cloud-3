#!/bin/bash

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
python3 -m pip install --user ansible-core
echo "export PATH=$PATH:/root/.local/bin" >> /root/.bashrc


$(date > /tmp/date.txt)
echo "Ubuntu" >> /tmp/date.txt

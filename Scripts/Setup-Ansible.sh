#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt update
DEBIAN_FRONTEND=noninteractive apt install -y python3 python3-simplejson python3-jinja2 python3-dev python3-venv python3-pip libffi-dev gcc libssl-dev curl git vim sshpass
pip3 install -U pip

pip3 install --upgrade pip
pip install -U 'ansible<2.10'

if ! [ -L /etc/ansible ]; then
  rm -rf /etc/ansible
  ln -fs /vagrant/ansible /etc/ansible
fi
pip install pywinrm

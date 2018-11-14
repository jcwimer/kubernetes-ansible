#!/bin/bash
apt-get update -qq
apt-get install -y -qq \
  python-dev \
  python-pip \
  python-setuptools

pip install --upgrade setuptools
pip install ez_setup
pip install pipenv
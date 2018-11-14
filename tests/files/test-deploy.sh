#!/bin/bash
script_dir="$( dirname $(readlink -f ${BASH_SOURCE[0]}))"
project_dir=${script_dir}/../..
cd $project_dir

export PRIVATE_KEY=/home/vagrant/test_rsa; 
export DEPLOY_USER=vagrant

cp tests/files/hosts hosts
cp tests/files/group_vars_all group_vars/all
bash supporting-scripts/run-setup.sh

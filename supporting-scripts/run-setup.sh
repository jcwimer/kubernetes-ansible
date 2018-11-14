#!/bin/bash
# cd to project directory
script_dir="$(dirname $(readlink -f ${BASH_SOURCE[0]}))"
project_dir="${script_dir}/../"
private_key=${PRIVATE_KEY}

cd ${project_dir}

# Run
pipenv install
pipenv run ansible-playbook -u ${DEPLOY_USER} -i hosts --ssh-common-args="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" --private-key=${private_key} playbooks/site.yml

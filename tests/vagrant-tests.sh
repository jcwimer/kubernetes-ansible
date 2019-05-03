#!/bin/bash

project_dir="$(dirname $( dirname $(readlink -f ${BASH_SOURCE[0]})))"
source ${project_dir}/tests/lib/test-function.sh

function main {
  cd ${project_dir}
  build-infrastructure
  run-tests
  echo Testing idempotency.
  run-tests
  destroy-infrastructure
}

function build-infrastructure {
  trap "echo 'vagrant up failed'; destroy-infrastructure; exit 1" ERR
    echo Building vagrant infrastructure
    vagrant up > /dev/null
  trap - ERR
}

function run-ssh-command {
  local machine="${1}"
  local command="${2}"
  vagrant ssh "${machine}" -c "${command}"
}

function run-tests {
  trap "destroy-infrastructure; exit 1" ERR

    testbash "Running command on a vagrant node should not fail." \
      "run-ssh-command client 'ls /vagrant'"

    testbash "Client vagrant machine can ssh into bootstrap." \
      "run-ssh-command client 'ssh -o StrictHostKeyChecking=no -i /home/vagrant/test_rsa vagrant@192.168.254.2 ls'"

    testbash "Running deploy script should not fail." \
      "run-ssh-command client 'bash /vagrant/tests/files/test-deploy.sh'"

    echo Giving containers time to start up.
    sleep 90s

    local kubectl_config="export KUBECONFIG=/rke/kube_config_rke-k8s.yaml"
    local curl_params="--silent --fail --max-time 10"

    number_of_ready_nodes=$(run-ssh-command master "sudo bash -c '${kubectl_config}; kubectl get nodes | grep -v STATUS | grep Ready | wc -l'")
    testbash "There should be 4 nodes in Ready state." \
      "test ${number_of_ready_nodes} -eq 4"
  trap - ERR
}

function destroy-infrastructure {
  trap "echo 'vagrant destroy failed'; exit 1" ERR
    echo Tearing down vagrant infrastructure
    vagrant destroy -f > /dev/null
  trap - ERR
}

main
exit 0
#!/bin/bash
mon_namespace="rook-ceph"
mon_pod=$(kubectl -n "${mon_namespace}" get pods | grep mon0 | awk '{print $1}')


function run_command () {
  local pod="${1}"
  local namespace="${2}"
  local command="${3}"

  kubectl -n "${namespace}" exec -it "${pod}" -- ${command}
}

function run_command_on_mon () {
  local command="${1}"
  run_command "${mon_pod}" "${mon_namespace}" "${command}"
}

admin_key=$(run_command_on_mon "ceph auth get-key client.admin")
kubectl create secret generic ceph-secret \
    --type="kubernetes.io/rbd" \
    --from-literal=key="${admin_key}" \
    --namespace=rook-ceph


run_command_on_mon "ceph osd pool create kube 1024 1024"
run_command_on_mon "ceph auth get-or-create client.kube mon 'allow r' osd 'allow rwx pool=kube"
kube_key=$(run_command_on_mon "ceph auth get-key client.kube")
kubectl create secret generic ceph-secret-kube \
    --type="kubernetes.io/rbd" \
    --from-literal=key="${kube_key}" \
    --namespace=rook-ceph

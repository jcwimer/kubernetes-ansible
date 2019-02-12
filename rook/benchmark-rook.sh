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

run_command_on_mon "ceph status"
run_command_on_mon "ceph osd pool create scbench 100 100"
run_command_on_mon "ceph osd pool application enable scbench rbd"
run_command_on_mon "rados bench -p scbench 10 write --no-cleanup"
run_command_on_mon "rados bench -p scbench 10 seq"
run_command_on_mon "rados bench -p scbench 10 rand"
#run_command_on_mon "rados -p scbench cleanup"

#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"

function testbash() {
  local name="${1}"
  shift
  local command="${@}"
  eval $command
  local return=$?
  if [[ ! $return -eq 0 ]]; then
    echo "${red}FAILED: ${name}${reset}"
    return 1
  else
    echo "${green}PASSED: $name${reset}"
    return 0
  fi
}
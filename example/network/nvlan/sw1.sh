#!/bin/bash
export RUN_DIR=$(pwd)
export PATH=${PATH}:${RUN_DIR}/network/cisco

. switch.sh



create_vlan_by_name  10       "VL-10"


interface_to_vlan    10       f0/1 f1/1 f2/1


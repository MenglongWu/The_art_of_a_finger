#!/bin/bash
export RUN_DIR=$(pwd)
export PATH=${PATH}:${RUN_DIR}/network/cisco

. switch.sh



create_vlan_by_name  30       "VL-30"
create_vlan_by_name  40       "VL-40"


interface_to_vlan    30       f1/1 f0/1
interface_to_vlan    40       f2/1 f3/1


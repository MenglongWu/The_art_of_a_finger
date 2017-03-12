#!/bin/bash
export RUN_DIR=$(pwd)
export PATH=${PATH}:${RUN_DIR}/network/cisco

. switch.sh



create_vlan_by_name  10       "Faculty/Staff"
create_vlan_by_name  20       "Students"
create_vlan_by_name  30       "Guest(Default)"
create_vlan_by_name  99       "Management&Native"


interface_to_trunk   f0/1  f0/3

native_to_trunk      f0/1      99
native_to_trunk      f0/3      99

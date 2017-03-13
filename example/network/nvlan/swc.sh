export RUN_DIR=$(pwd)
export PATH=${PATH}:${RUN_DIR}/network/cisco

. switch3.sh


ip_routing

create_vlan_by_name  10       "VL-10"
create_vlan_by_name  20       "VL-20"
create_vlan_by_name  30       "VL-30"
create_vlan_by_name  40       "VL-40"
create_vlan_by_name  50       "VL-50"

interface_to_vlan    10       f0/1
interface_to_vlan    20       f0/2
interface_to_vlan    30       f0/3
interface_to_vlan    40       f0/4
interface_to_vlan    50       f0/10




vlan_ip  10 192.168.1.1 255.255.255.0
vlan_ip  20 192.168.2.1 255.255.255.0
vlan_ip  30 192.168.3.1 255.255.255.0
vlan_ip  40 192.168.4.1 255.255.255.0
vlan_ip  50 192.168.5.1 255.255.255.0








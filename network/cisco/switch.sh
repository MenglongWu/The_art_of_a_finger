#!/bin/bash
. common.sh

############################################################
# 验证过
# $1 vlan id
# $2 interface
function interface_to_vlan() {
	param_less $FUNCNAME $# 2

	echo "vlan database"
	echo "vlan ${1}"
	echo "exit"

	echo "conf t"
	echo "int ${2}"
	echo "no sh"
	echo "switchport mode access"
	echo "sw acc vlan ${1}"
	echo -e "exit\nexit\n"
}

############################################################
# 验证过
# $1 interface
function interface_to_trunk() {
	param_less $FUNCNAME $# 1

	echo "conf t"
	echo "int ${1}"
	echo "no sh"
	echo "switchport mode trunk"
	echo -e "exit\nexit\n"
}


############################################################
# 验证过
# $1 interface
# $2 vlan
function add_vlan_to_trunk() {
	param_less $FUNCNAME $# 2

	echo "conf t"
	echo "int ${1}"
	echo "no sh"
	# echo "switchport mode trunk"
	echo "switchport trunk allowed vlan add ${2}"
	echo -e "exit\nexit\n"
}

# $1 interface
# $2 vlan
# function trunk_access_vlan() {
# 	param_less $FUNCNAME $# 2

# 	echo "conf t"
# 	echo "int ${1}"
# 	echo "no sh"
# 	echo "sw trunk allowed vlan ${2}"
# 	echo -e "exit\nexit\n"
# }


# $1 vlan 
# $2 IP
# $3 mask
# function vlan_ip() {
# 	param_less $FUNCNAME $# 3

# 	echo "vlan database"
# 	echo "vlan ${1}"
# 	echo "exit"

# 	echo "conf t"
# 	echo "interface vlan ${1}"
# 	echo "no sh"
# 	echo "ip address ${2} ${3}"
# 	echo -e "exit\nexit\n"
# }



# interface_to_vlan f0/1 10
# interface_to_vlan f0/2 10
# interface_to_vlan f0/3 10
# interface_to_vlan f0/4 10
# 
# interface_to_vlan f0/5 11
# interface_to_vlan f0/6 11
# interface_to_vlan f0/7 11
# interface_to_vlan f0/8 11
# 
# 
# 
# interface_to_trunk f0/10
# interface_to_trunk f0/11
# 
# 
# 
# 
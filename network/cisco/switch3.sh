#!/bin/bash
. common.sh
function create_vlan() {
	echo "vlan database"
	echo "vlan ${1}"
	echo "exit"
}


# 验证过
# $1 interface
# $2 vlan id
function interface_to_vlan() {
	param_less $FUNCNAME $# 2

	create_vlan ${1}

	echo "conf t"
	echo "int ${2}"
	echo "no sh"
	echo "switchport mode access"
	echo "sw acc vlan ${1}"
	echo -e "exit\nexit\n"
}


# 验证过
# $1 interface
function interface_to_trunk() {
	param_less $FUNCNAME $# 1

	echo "conf t"
	echo "int ${1}"
	echo "no sh"
	echo "switchport trunk encapsulation dot1q"
	echo "switchport mode trunk"
	echo -e "exit\nexit\n"
}

# $1 interface
# $2 vlan
function trunk_add_vlan() {
	# param_less $FUNCNAME $# 2

	# echo "conf t"
	# echo "int ${1}"
	# echo "no sh"
	# echo "switchport mode trunk"
	# echo "switchport trunk allowed vlan add ${2}"
	# echo -e "exit\nexit\n"
	echo ""
}

# $1 interface
# $2 vlan
# function trunk_access_vlan() {
# 	echo "conf t"
# 	echo "int ${1}"
# 	echo "no sh"
# 	echo "sw trunk allowed vlan ${2}"
# 	echo -e "exit\nexit\n"
# }

function sw3_int_dot1q() {
	param_less $FUNCNAME $# 2

	echo "conf t"
	echo "int ${1}"
	echo "switchport trunk encapsulation dot1q"
	echo -e "exit\nexit\n"
}
# 验证过
# $1 vlan 
# $2 IP
# $3 mask
function vlan_ip() {
	param_less $FUNCNAME $# 3


	echo "conf t"
	echo "interface vlan ${1}"
	echo "no sh"
	echo "ip address ${2} ${3}"
	echo -e "exit\nexit\n"
}

# 验证过
# $1 interface
# $2 vlan
function add_vlan_to_trunk() {
	param_less $FUNCNAME $# 2
	create_vlan ${2}


	echo "conf t"
	echo "int ${1}"
	echo "no sh"
	echo "switchport trunk allowed vlan add ${2}"
	echo -e "exit\nexit\n"
}

# 
function ip_routing() {
	echo "conf t"
	echo "ip routing"
	echo -e "exit\n"
}

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
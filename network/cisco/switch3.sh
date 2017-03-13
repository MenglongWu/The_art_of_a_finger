#!/bin/bash
. common.sh

# $1 vlan 号
# $2 vlan 别名
function create_vlan_by_name() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 2

	echo "vlan database"
	echo "vlan 				${1}"
	echo "exit"

	
	if [ "$#" -gt 1 ]
	then
		echo "conf t"
		echo "vlan 				${1}"
		echo "name 				${2}"
		echo -e "exit\nexit"
	fi



}

function create_mutil_vlan() {
	param_less $FUNCNAME $# 1

	echo "vlan database"
	
	declare -a vlan_s=($@)
	for vlan in "${vlan_s[@]}"
	do
		echo "vlan 				${vlan}"
	done
	
	echo "exit"


}



############################################################
# 验证过
# $1 vlan id
# $2 interface
function interface_to_vlan() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 2
	vlan_num=${1}
	shift
	declare -a intface_s=($@)

	create_mutil_vlan ${vlan_num}

	echo "conf t"
	for int in "${intface_s[@]}"
	do
		echo "interface 			${int}"
		echo "no shutdown"
		echo "switchport mode access"
		echo "switchport access vlan ${vlan_num}"
		echo "exit"
	done
	
	echo "exit"
}

# 验证过
# $1 interface
function interface_to_trunk() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 1

	declare -a intface_s=($@)
	
	echo "conf t"
	for int in "${intface_s[@]}"
	do
		echo "int 				${int}"
		echo "no shutdown"
		echo "switchport trunk encapsulation dot1q"
		echo "switchport mode trunk"
		echo "exit"
	done
	echo -e "exit\n"
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
	code_comments $FUNCNAME $@
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
	create_mutil_vlan ${2}


	echo "conf t"
	echo "int ${1}"
	echo "no sh"
	echo "switchport trunk allowed vlan add ${2}"
	echo -e "exit\nexit\n"
}

# 
function ip_routing() {
	code_comments $FUNCNAME $@
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
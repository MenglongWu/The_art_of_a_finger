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
# export -f create_vlan_by_name

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



# $1 interface
# $2 vlan id
function no_sh() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 1

	echo "conf t"
	echo "int 				${1}"
	echo "no sh"
	echo -e "exit\n"
}


# $1 vlan
# $2 interface 
function _encapsulation_dot1Q() {
	vlan_num=${1}
	shift	
	declare -a intface_s=($@)
	# echo -------${intface_s}
	echo "conf t"
	for int in "${intface_s[@]}"
	do
		echo "interface 			${int}"
		echo "no shutdown"
		echo "encapsulation dot1Q 		${vlan_num}"
		echo "exit"
	done
	echo -e "exit\n"
}
# $1 encapsulation type [dot1Q]
# $3 vlanid
# $2 interface
function encapsulation () {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 2

	encap_type=${1}
	shift
	declare -a intface_s=($@)

	case ${encap_type} in
		"dot1Q")
			_encapsulation_dot1Q $@
			return
			;;
		# TODO
	esac
	echo "encapsulation unknow"
	exit
	
}

# $1 sub interface 
# $2 vlan id
# $3 IP
# $4 mask
# function interface_dot1q() {
# function router_int_dot1q() {
# 	param_less $FUNCNAME $# 4

# 	# 必须满足 f0/0.n 子接口格式
# 	var=$(echo "$1" | awk  -F '.' '{print $2}')
# 	param_error $FUNCNAME "${var}" ${1}


	

# 	echo "conf t"
# 	echo "interface ${1}"
# 	echo "encapsulation dot1Q ${2}"
# 	echo "ip address ${3} ${4}"
# 	echo -e "exit\nexit\n"
# }

# $1 name
# $2 pool subnet
# $3 pool mask
# $4 gateway
# $5 dns server


function dhcp_pool() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 5

	echo "conf t"
	echo "service dhcp"
	echo "ip dhcp pool 			${1}"
	echo "network 			${2} ${3}"
	echo "default-router 			${4}"
	echo "dns-server 			${5}"
	echo -e "exit\nexit\n"
}

# $1 IP
function dhcp_excluded() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 1
	declare -a ip_s=($@)

	echo "conf t"
	
	for ip in "${ip_s[@]}"
	do
		echo "ip dhcp excluded-address 	${ip}"
	done
	echo -e "exit\n"
}

function dhcp_excluded_range() {
	code_comments $FUNCNAME $@
	echo "conf t"
	# echo "ip dhcp excluded-address ${1}"
	# todo
	echo -e "exit\n"
}


# 验证过
# $1 sub interface 
# $2 IP
# $3 mask
function subinterface_ip() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 3

	echo "conf t"
	echo "interface ${1}"
	echo "no sh"
	echo "ip address ${2} ${3}"
	echo -e "exit\nexit\n"
}

# $1 sub interface 
# $2 IP
# $3 mask
function interface_ip() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 3

	echo "conf t"
	echo "interface ${1}"
	echo "no sh"
	echo "ip address ${2} ${3}"
	echo -e "exit\nexit\n"
}

# 验证过
# $1 ip
# $2 mask
# $3 next hope
function static_route() {
	code_comments $FUNCNAME $@
	param_less $FUNCNAME $# 3

	echo "conf t"
	echo "ip route ${1}  ${2}  ${3}"
	echo -e "exit\n"
}

# no_sh f0/0

# interface_dot1q f0/0.1 10 192.168.4.1 255.255.255.0
# interface_dot1q f0/0.2 11 192.168.5.1 255.255.255.0

# dhcp_excluded 192.168.1.1
# dhcp_excluded 192.168.2.1
# dhcp_excluded 192.168.3.1
# dhcp_excluded 192.168.4.1
# dhcp_excluded 192.168.4.2
# dhcp_excluded 192.168.4.4
# dhcp_excluded 192.168.4.6

# dhcp_pool \
# 	VL-10 \
# 	192.168.4.0 \
# 	255.255.255.0 \
# 	192.168.4.1 \
# 	10.0.1.1

# dhcp_excluded 192.168.5.1
# dhcp_excluded 192.168.5.2
# dhcp_excluded 192.168.5.4
# dhcp_excluded 192.168.5.6




# dhcp_pool \
# 	VL-20 \
# 	192.168.5.0 \
# 	255.255.255.0 \
# 	192.168.5.1 \
# 	10.0.1.1
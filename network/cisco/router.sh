#!/bin/bash
. common.sh

# $1 interface
# $2 vlan id
function no_sh() {
	param_less $FUNCNAME $# 2

	echo "conf t"
	echo "int ${1}"
	echo "no sh"
	echo -e "exit\n"
}



# $1 sub interface 
# $2 vlan id
# $3 IP
# $4 mask
# function interface_dot1q() {
function router_int_dot1q() {
	param_less $FUNCNAME $# 4

	# 必须满足 f0/0.n 子接口格式
	var=$(echo "$1" | awk  -F '.' '{print $2}')
	param_error $FUNCNAME "${var}" ${1}


	

	echo "conf t"
	echo "interface ${1}"
	echo "encapsulation dot1Q ${2}"
	echo "ip address ${3} ${4}"
	echo -e "exit\nexit\n"
}

# $1 name
# $2 pool subnet
# $3 pool mask
# $4 gateway
# $5 dns server


function dhcp_pool() {
	param_less $FUNCNAME $# 5

	echo "conf t"
	echo "service dhcp"
	echo "ip dhcp pool ${1}"
	echo "network ${2} ${3}"
	echo "default-router ${4}"
	echo "dns-server ${5}"
	echo -e "exit\n"
}

# $1 IP
function dhcp_excluded() {
	param_less $FUNCNAME $# 1

	echo "conf t"
	echo "ip dhcp excluded-address ${1}"
	echo -e "exit\n"
}

function dhcp_excluded_range() {
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
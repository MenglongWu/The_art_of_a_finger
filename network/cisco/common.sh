#!/bin/bash

#
# $1 函数名
# $2 当前参数
# $3 函数最大参数个数
function param_less() {
	if [ "$2" -lt "$3" ]; then
		echo "$1 参数不足 $3" > /dev/pty1
		exit;
	fi
}

#
# $1 函数名
# $2 参数
# $3 错误的内容
function param_error() {
	# echo [1: ${1}   2:  ${2} 3:  ${3}]
	if [ "${2}" == "" ]; then
		echo "$1 参数错误 ${3}"
		exit;
	fi
	
}
#!/bin/bash

export RUN_DIR=$(pwd)
export PATH=${PATH}:${RUN_DIR}/bin
export H1=0
export H2=0
export H3=0
export H4=0
. common_style.sh
. test.sh

# function 
# Title
# com11
# OpenResource python su

# O=`getopt   a:c:P:: "$@"`
# # eval set -- "$O"
# echo [$O]
# while  [ -n "$1" ]
# do
#     # echo "\$1 is $1"
#     case $1 in
#         -a)
#             echo aaaa
#             echo $@
#             ;;
#         -c)
#             echo ccc
#             ;;
#         -P)
#             echo PP
#             echo $@
#             ;;
# 	esac
# 	shift
# done



Title "基本栈"

# ReportParam -a "pa1 pa2 p3" -b b3 -c c4 -a "go"
# ReportTrace default.elf
# ProcessStack $(pidof python)
# ReportOpenResource -a "python su" -b f 
# ReportOpenResource -a "pa1 pa2 p3" -b b3 -c c4 -a "go"
# _getopt_openresource -p "python bash" -t  -m -s 32 -s 2
# _getopt_openresource -p "python bash gdm-session-worker" -t  -m 
_getopt_openresource -p "default.elf" 
ReportNetState
# ReportOpenResource -a 'pa1 pa2 p3' -b b3 -c c4 -a "go"
# ReportTrace python

exit
# Memory
Top
ReportDiskSpace
ReportIO


ReportNetState
IpTables

Interrupt
# OpenResource default.elf
# OpenResource python
OpenResource python su


# NetServer
#while [ 1 ]
#do
#	sleep 1
#	echo "fsdfsdf"
#	sleep 1
#	echo "fsdfsdf3333333"

#done

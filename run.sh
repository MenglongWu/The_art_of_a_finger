#!/bin/bash

export RUN_DIR=$(pwd)
export PATH=${PATH}:${RUN_DIR}/bin
export H1=0
export H2=0
export H3=0
. comon_style.sh
. test.sh

# function 
# Title
# com11


Title

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

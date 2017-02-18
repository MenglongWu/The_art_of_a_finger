#!/bin/bash

function Memory() {
	((H1++))
	SubjectTitle_H1 "${H1} 内存"
	
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} 内存简述"
	Form_Start
	free 
	Form_End

	((H2++))
	SubjectTitle_H2 "${H1}.${H2} 内存详细"
	Form_Start
	cat /proc/meminfo
	Form_End
}
export -f Memory

function Top() {
	((H1++))
	SubjectTitle_H1 "${H1} TOP"
	Form_Start
	top -n 1 -b | head -n 5
	Form_End
}
export -f Top


function ReportDiskSpace() {
	((H1++))
	SubjectTitle_H1 "${H1} 磁盘空间"
	Form_Start
	df
	Form_End	
}

export -f ReportDiskSpace

function Interrupt() {
	((H1++))
	SubjectTitle_H1 "${H1} 中断"
	Form_Start
	cat /proc/interrupts
	Form_End	
}

export -f Interrupt



function iptables_nat() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} NAT"
	Form_Start
	iptables -t nat -nL
	Form_End
}

function iptables_nL() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} 访问控制"
	Form_Start
	iptables -nL
	Form_End
}

function IpTables() {
	H2=0
	((H1++))
	SubjectTitle_H1 "${H1} iptable"
	iptables_nL
	iptables_nat
}

export -f IpTables





function _2net_tcp() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} TCP连接"
	Form_Start
	netstat -pnat
	Form_End
}

function _2net_if() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} 网络接口"
	Form_Start
	netstat -i
	Form_End
}
function _2net_arp() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} ARP表"
	Form_Start
	cat /proc/net/arp 
	Form_End

	# cat 读取arp表
	# awk 从第二行开始读取mac列
	# sort 以 ':' 做分割排序mac
	# uniq 找到重复项（uniq必须与sort联合使用）
	conflict=$(cat /proc/net/arp | awk -F ' ' '{if (NR>1) print $4}' | sort -t ':' | uniq -d)
	SubjectTitle_Warrning "ARP冲突"
	Font_Color_Start red
	if [ "${conflict}" != "" ]
	then
		Form_Start
	    echo ${conflict}
	    Form_End
	fi  
	Font_Color_End
}

function _2net_route() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} 路由表"
	Form_Start
	netstat -rn
	Form_End	
}
export -f _2net_route

function ReportNetState() {
	H2=0
	((H1++))
	SubjectTitle_H1 "${H1} 网络状态"
	_2net_if
	_2net_arp
	_2net_route	
	_2net_tcp
	
}

export -f ReportNetState



function OpenFiles() {
	((H4++))
	SubjectTitle_H3 "${H1}.${H2}.${H3}.${H4} ${2}(${1}) 打开文件数"
	Form_Start
	ls /proc/${1}/fd -l
	Form_End
}


function ProcessTree() {
	((H4++))
	SubjectTitle_H3 "${H1}.${H2}.${H3}.${H4} ${2}(${1}) 进程树"
	Form_Start
	pstree -p ${1}
	Form_End
}

# 第一列  size:任务虚拟地址空间大小
# 第二列  Resident：正在使用的物理内存大小
# 第三列  Shared：共享页数
# 第四列  Trs：程序所拥有的可执行虚拟内存大小
# 第五列  Lrs：被映像倒任务的虚拟内存空间的库的大小
# 第六列  Drs：程序数据段和用户态的栈的大小
# 第七列 dt：脏页数量
function ProcessMem() {
	((H4++))
	SubjectTitle_H3 "${H1}.${H2}.${H3}.${H4} ${2}(${1}) 该进程内存使用情况"
	Form_Start
	echo size Res Shared Trs Lrs Drs dt
	cat /proc/${1}/statm
	Form_End
}

function ProcessStack() {
	((H4++))
	SubjectTitle_H3 "${H1}.${H2}.${H3}.${H4} ${2}(${1}) 栈"
	Form_Start
	pstack ${1}
	pstack ${1}
	pstack ${1}
	Form_End
}

function _2param()
{
	H3=0

	while (($#>0))
	do
		((H2++))
	 	pid=$(pidof $1)

	 	H3=0
		SubjectTitle_H2 "${H1}.${H2} ${1}"
		Form_Start
		echo 同名PID ${pid}
		Form_End


	 	for var in ${pid[@]};do
	 		H4=0
	 		((H3++))
			ProcessTree $var $1
			ProcessMem  $var $1
			ProcessStack  $var $1
			# OpenFiles $var
		done
	 	
      	shift
  	done
}

function OpenResource() {
	H2=0
	((H1++))
	
	SubjectTitle_H1 "${H1} 资源"

	_2param $@

}
export -f OpenResource


function NetServer() {
	((H1++))
	SubjectTitle_H1 "${H1} 网络服务"
	Form_Start
	netstat -ano | grep "LISTEN "
	Form_End
}

export -f NetServer


function _2iostat() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} iostat"
	Form_Start
	iostat | tail -n +3
	Form_End
}

function _2mpstat() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} mpstat"
	Form_Start
	mpstat | tail -n +3
	Form_End
}

function ReportIO() {
	H2=0;
	((H1++))
	SubjectTitle_H1 "${H1} IO吞吐"
	_2iostat
	_2mpstat
}
export -f ReportIO



# 内核栈
# watch -n 1 cat /proc/$(pidof default.elf)/stack
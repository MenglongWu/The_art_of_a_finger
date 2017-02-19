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
	
	if [ "${conflict}" != "" ]
	then
		SubjectTitle_Warrning "ARP冲突"
		Form_Start
		for var in ${conflict[@]}
		do
			echo -e ${var}
		done
	    
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
	total=$(ls /proc/${1}/fd -l | wc -l)
	((total--))
	echo "打开文件总数" $total
	ls /proc/${1}/fd -l | head -n 10
	if [ ${total} -gt 10 ]
	then
		echo "..........余下省略.........."
	fi
	Form_End


	
	
	if [ ${total} -gt 100 ]
	then
		SubjectTitle_Warrning "是否存在未释放文件资源"
		Form_Start
	    echo "打开文件总数" $total
	    Form_End
	fi  
	
}


function ProcessTree() {
	((H4++))
	SubjectTitle_H3 "${H1}.${H2}.${H3}.${H4} ${2}(${1}) 进程树"
	Form_Start
	pstree -pn ${1}
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
	echo arg3 ${3}
	for (( i = 0; i < ${3}; i++ ))
	do
		pstack ${1}
	done
	Form_End
}
export -f ProcessStack

function ProcessStatus() {
	((H4++))
	SubjectTitle_H3 "${H1}.${H2}.${H3}.${H4} ${2}(${1}) status"
	Form_Start
	cat /proc/${1}/status
	Form_End
}

function ProcessStat() {
	((H4++))
	SubjectTitle_H3 "${H1}.${H2}.${H3}.${H4} ${2}(${1}) stat"
	item=($(cat /proc/${1}/stat))
	# item=(1 2)
	# Form_Start
	# for var in ${item[@]}
	# do
	

	var_flt="min_flt ${item[9]}  \n \
			cmin_flt   ${item[10]}  \n \
			maj_flt    ${item[11]}  \n \
			cmaj_flt   ${item[12]}  \n"

	var_time="utime ${item[13]}  \n \
			stime   ${item[14]}  \n \
			cutime    ${item[15]}  \n \
			cstime   ${item[16]}  \n"
				# \"- maj_flt\" ${item[11]}  \"\n\"\
				# \"- cmaj_flt\" ${item[12]}  \"\n\""
	# var_flt="\"a b\" \"cs\""
	# echo -e " - 任务状态\t" ${item[2]} "\n"\
	# 			"- ppid" ${item[3]}  "\n"\
	# 			${var_flt} \
	# 			${var_time}
	echo -e ${var_flt}
	echo -e ${var_time}
	# done
	
	# Form_End
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

		
	 	for var in ${pid[@]}
	 	do
	 		H4=0
	 	 	((H3++))
			ProcessTree $var $1
			ProcessMem  $var $1
			ProcessStack  $var $1 2
			OpenFiles $var
		done
		# let "H3++"

	 	
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


function _2trace_detail() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} 跟踪详细"
	strace -o ${1}.trace -Ttt -p $(pidof ${1}) &
	sleep 5
	kill $(pidof strace)
	Form_Start
	cat ${1}.trace
	Form_End
}

function _2trace_count() {
	((H2++))
	SubjectTitle_H2 "${H1}.${H2} 跟踪计数"
	strace -o ${1}.trace.c -Ttt -p $(pidof ${1}) -c &
	sleep 5
	kill $(pidof strace)
	Form_Start
	cat ${1}.trace.c
	Form_End
}

function ReportTrace() {
	H2=0;
	((H1++))
	SubjectTitle_H1 "${H1} ${1} IO吞吐"
	# _2trace_detail $@
	# _2trace_count $@
}
export -f ReportTrace

function _getopt_openresource() {
	# echo "param number" $#



	# 分析参数
	while getopts "ctmp:s:" argv
	do
		case $argv in
			p)
				rep_process=1
				rep_process_argv=$OPTARG
				# echo [$OPTARG]
				;;
			c)
				# echo [$OPTARG]
				;;
			t)
				rep_tree=1
				# echo [$OPTARG]
				;;
			m)
				rep_mem=1
				# echo [$OPTARG]
				;;
			s)
				rep_stack=1
				rep_stack_argv=$OPTARG
				# echo [$OPTARG]
				;;
			# TODO 添加新选项
		esac
	done

	# echo process $rep_process argv $rep_process_argv
	# echo stack $rep_stack argv $rep_stack_argv

	# 
	if [ ${rep_process} -eq 0 ]
	then
		return
	fi
	a=Title
	# 逐个进程名处理
	
	((H1++))
	SubjectTitle_H1 "${H1} 资源"
	for var in ${rep_process_argv[@]};do
		H3=0
		((H2++))

		pids=$(pidof $var)
		SubjectTitle_H2 "${H1}.${H2} ${var}"
		Form_Start
		echo 同名PID ${pids}
		Form_End




		for onepid in ${pids[@]};do
			H4=0
			((H3++))


			if [ ${rep_tree} ]
			then
				ProcessTree ${onepid} ${var}
			fi


			if [ ${rep_mem} ]
			then
				ProcessMem ${onepid} ${var}
			fi


			if [ ${rep_stack} ]
			then
				ProcessStack ${onepid} ${var} ${rep_stack_argv}
			fi

			OpenFiles ${onepid} ${var}
			ProcessStatus ${onepid} ${var}
			ProcessStat ${onepid} ${var}
			# TODO 有什么新的功能在这添加
		done
	done
}
export -f _getopt_openresource

function ReportOpenResource() {
	H2=0
	((H1++))
	
	SubjectTitle_H1 "${H1} 资源"
	echo "param nu" $#
	k=(-a 'pa1 pa2 p3' -b b3 -c c4 -a "go")

	g='getopts "a:b:c:" -- "$@"'
	echo "g="  $g
	for i in $@; do
	    echo ---$i
	done

	_getopt_openresource ${k[@]}
}
export -f ReportOpenResource


function ReportParam() {
	H2=0;
	((H1++))
	SubjectTitle_H1 "${H1} ${1} param"
	
	echo '$*' $*
	echo '$@' $@
	echo '$#' $#
	echo '$_' $_
	echo '$$' $$
	echo '$!' $!
	echo '$?' $?
	echo '$1' $1
	echo '$1' $1
	echo '$2' $2
	echo '$3' $3
	echo '$4' $4
	echo '$5' $5

	k=(${2})
	# k=(pa1 pa2 p3)
	# echo ${k}
	# echo 'k1' ${k[2]} '#{k}'${#k[@]}
	echo ------
	echo k[0]
	echo k[1]
	echo k[2]
	echo k[3]


	for var in ${k[@]};do
		echo $var
	done

	echo "do getopts"
	while getopts "a:b:c" arg
	do
		case $arg in
			a)
				echo [$OPTIND] [$OPTARG]
				;;
			b)
				echo [$OPTIND] [$OPTARG]
				;;
		esac
	done
	echo ---${H3}
	# $OPTIND



}
export -f ReportParam
# 内核栈
# watch -n 1 cat /proc/$(pidof default.elf)/stack

# strace -o default.elf -Ttt -p $(pidof default.elf) 
# pstack $(pidof default.elf)  
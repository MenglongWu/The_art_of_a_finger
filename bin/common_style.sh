#!/bin/bash
function unname() {
	SubjectTitle_H1 xxxxxx
	Form_Start 
	
	Form_End	
}

export -f unname


function Title() {	
	now=$(date "+%Y-%m-%d %H:%M:%S")
	poweron=$(date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S")
	net=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')

	echo -e '\t序列号  :' ${SN} '   \n' \
			'\t主机    :' $(hostname) '   \n' \
			'\t启动时间:' ${poweron} '  ' '当前时间 :' ${now} '\n' \
			'\t内核    :' $(uname -s -n -r) '   \n' \
			'            '$(uname -v) '\n' \
			'\t网络    :' ${net}
	echo -----------------------------------------------------------
}
export -f Title





# 1级标题，段前空格1行，首行顶格
# param 1 : 标题名称
function SubjectTitle_H1() {
	echo -e "\n#" ${1} \
	"\n----------------------------------------------------------------"
}
export -f SubjectTitle_H1

# 2级标题，段前空格1行，首行空2格
# param 1 : 标题名称
function SubjectTitle_H2() {
	echo -e "\n## " ${1} \
	"\n----------------------------------------------------------------"
}
export -f SubjectTitle_H2


# 2级标题，段前空格1行，首行空4格
# param 1 : 标题名称
function SubjectTitle_H3() {
	echo -e "\n###  " ${1} \
	"\n----------------------------------------------------------------"
}
export -f SubjectTitle_H3

# 2级标题，段前空格1行，首行空4格
# param 1 : 标题名称
function SubjectTitle_H4() {
	echo -e "\n####    " ${1} \
	"\n----------------------------------------------------------------"
}
export -f SubjectTitle_H4



function SubjectTitle_Warrning() {
	# echo -e "\n#### " ${1} 
	echo -e "**" ${1} "**"
}
export -f SubjectTitle_Warrning

# 具有自身组织结构内容开始
# 在Form_Start、Form_End之间的风格属性无效
function Form_Start() {
	echo -e '\n```'
}
export -f Form_Start

# 具有自身组织结构内容开始
# 在Form_Start、Form_End之间的风格属性无效
function Form_End() {
	echo -e '```'
}
export -f Form_End


# 设置字体颜色
# param 1 字体颜色
# 在Form_Start、Form_End之前调用无效
function Font_Color_Start() {
	echo "<font color="${1}">"
}
export -f Font_Color_Start


# 在Form_Start、Form_End之前调用无效
function Font_Color_End() {
	echo "</font>"
}
export -f Font_Color_End
#!/usr/bin/env bash
# A simple URL status verifier
# version 0.0.1
clear
# suppressing errors, uncomment this line to enable debugging
exec 2> /dev/null
# The regex pattern to identify URLs in text
URL_PATTERN="(http|https)://[^ ,\">'{}!()]+"
printf "%125s\n"| tr " " =
#colors
ESC="\033["
BOLD=$ESC"1m"
RESET=$ESC";0m"
RED=$'\e[1;31m'
MAG=$'\e[1;35m'
# LOGO :)
cat << "EOF"
#
#    ____    U _____ u     _        ____       ____        _
#   |  _"\   \| ___"|/ U  /"\  u   |  _"\   U |  _"\ u    |"|
#  /| | | |   |  _|"    \/ _ \/   /| | | |   \| |_) |/  U | | u
#  U| |_| |\  | |___    / ___ \   U| |_| |\   |  _ <     \| |/__
#   |____/ u  |_____|  /_/   \_\   |____/ u   |_| \_\     |_____|
#    |||_     <<   >>   \\    >>    |||_      //   \\_    //  \\ 
#   (__)_)   (__) (__) (__)  (__)  (__)_)    (__)  (__)  (_")("_) ")"
#
#
EOF
echo -e "#	  ${MAG}*-A dead simple URL verifier for RST and MD docs-*${RESET}"
echo "#"
printf "%125s\n"| tr " " =
# default search directory is the current directory
arg=.
if [ -n "${1}" ];then
	arg=$1
fi
echo -e "${BOLD}Scanning URLs in all *.rst and *.md documents in the current directory (recursive)${RESET}"
echo  -e "${BOLD}Please wait, this will take a few seconds...${RESET}"
printf "%125s\n"| tr " " =
S_TIME=$SECONDS
url_array=(`find $arg -name "*.rst" -o -name "*.md" | xargs  -P 4 grep -Erho "$URL_PATTERN"  | sort | uniq`)
check_url () {
	#colors
	ESC="\033["
	BOLD=$ESC"1m"
	RESET=$ESC";0m"
	RED=$'\e[1;31m'
	MAG=$'\e[1;35m'
	n=$1
	if [ "${#n}" -gt 2 ];then
		stat=$(curl -Is -m 7 $n | head -n +1)
		s_array=($stat)
		s_code=${s_array[1]}
		if [ -z "${stat}" ];then
			printf "${BOLD}URL timed out ${RESET}	${MAG}  =>${RESET}	%-s\n" $n
		fi
		if [ -n "${stat}" ];then
			# uncomment to debug
			# set -xv
			if [ $s_code -gt 399 ];then
			# uncomment to debug
				# set +xv
				printf "${RED}URL returned a 4XX or a 5XX${RESET}	${MAG}  =>${RESET}	%-s\n" $n
			fi
		fi
	fi
}
export -f check_url
printf "%s\n" "${url_array[@]}" | xargs  -I {} -P 10  bash -c "check_url  {} $@"
F_TIME=$(( SECONDS - S_TIME ))
printf "%125s\n"| tr " " =
printf "Scan complete! Total time taken: %s seconds.\n" "$F_TIME"
printf "%125s\n"| tr " " =

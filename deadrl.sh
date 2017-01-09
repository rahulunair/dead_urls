#!/usr/bin/env bash
# A simple URL status verifier
# version 0.0.1
clear
# suppressing errors, uncomment this line to enable debugging
exec 2> /dev/null
source colors.sh
printf "%125s\n"| tr " " =
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
# The regex pattern to identify URLs in text
URL_PATTERN="(http|https)://[^ ,\">'{}!()]+"
# Color settings and LOGO
check_url () {
	# check_url: Tries to curl a supplied url and prints out dead/stale URLs
	#colors
	source colors.sh
	n=$1
	if [ "${#n}" -gt 2 ];then
		# giving timeout as 10 seconds
		# so that even if network speed is low, curl waits for 10 sec to try and recieve a response
		stat=$(curl -Is -m 5 $n | head -n +1)
		s_array=($stat)
		s_code=${s_array[1]}
		#if [ -z "${stat}" ];then
			# file_path=`grep -rl --include \*.rst --include \*.md $n $file_path`
	#		printf "${BOLD}URL timed out ${RESET}	${MAG}  =>${RESET}    ${BLU}%-s\n${RESET}" "$n"
	#		printf "${BOLD}File path     ${RESET}   ${MAG} =|${RESET}\n"
#			printf "%-s\n" "$file_path"
#		fi
		if [ -n "${stat}" ];then
			# uncomment to debug
			# set -xv
			if [ $s_code -gt 399 ];then
			# uncomment to debug
				# set +xv
				file_path=`grep -rl --include \*.rst --include \*.md $n $file_path`
				printf "${BOLD}URL returned 4XX or 5XX ${RESET}	${MAG}  =>${RESET}	  ${RED}%-s${RESET}\n" "$n"
				printf "${BOLD}File path     ${RESET}   ${MAG} =|${RESET}\n"
				printf "%-s\n" "$file_path"
			fi
		fi
	fi
}
# default search directory is the current directory
arg=.
if [ -n "${1}" ];then
	arg=$1
fi
file_path=$arg
export file_path
echo -e "${BOLD}Scanning URLs in all *.rst and *.md documents in the current directory (recursive)${RESET}"
echo  -e "${BOLD}Please wait, this will take a few seconds...${RESET}"
printf "%125s\n"| tr " " =
S_TIME=$SECONDS
url_array=(`find $arg -name "*.rst" -o -name "*.md" | xargs  -P 4 grep -Erho "$URL_PATTERN"  | sort | uniq`)
# Exports check_url function and is called for each URL (10 URLs are checked at one time, _p 10)
export -f check_url
printf "%s\n" "${url_array[@]}" | xargs  -I {} -P 15  bash -c "check_url  {} $@"

# stats and final output
count_urls=${#url_array[@]}
if [ -z "$count_urls" ];then
	count_urls=0
fi
F_TIME=$(( SECONDS - S_TIME ))
printf "%125s\n"| tr " " =
printf "Scan complete!\n"
printf "Total number of URLs scanned: %s\n" "$count_urls" 
printf "Time taken: %s seconds.\n" "$F_TIME"
printf "%125s\n"| tr " " =

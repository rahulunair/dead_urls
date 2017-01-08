#!/usr/bin/env bash
# A simple URL status verifier
# version 0.0.1
clear
# suppressing errors, uncomment this line to enable debugging
exec 2> /dev/null
# The regex pattern to identify URLs in text
URL_PATTERN="(http|https)://[^ ,\">'{}!()]+"
# Color settings and LOGO
source color_LOGO.sh
check_url () {
	# check_url: Tries to curl a supplied url and prints out dead/stale URLs
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
		    file_path=`grep -rl $n $file_path`
			printf "${BOLD}URL timed out ${RESET}	${MAG}  =>${RESET}	%-s\n" "$n"
			printf "${BOLD}File path     ${RESET}   ${MAG} =|${RESET}\n"
			printf "%-s\n" "$file_path"
		fi
		if [ -n "${stat}" ];then
			# uncomment to debug
			# set -xv
			if [ $s_code -gt 399 ];then
			# uncomment to debug
				# set +xv
				file_path=`grep -rl $n $file_path`
				printf "${BOLD}URL timed out ${RESET}	${MAG}  =>${RESET}	%-s\n" "$n"
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
printf "%s\n" "${url_array[@]}" | xargs  -I {} -P 10  bash -c "check_url  {} $@"

# stats and final output
count_urls=${#url_array[@]}
if [ -z "$count_urls" ];then
	count_urls=0
fi
F_TIME=$(( SECONDS - S_TIME ))
printf "%125s\n"| tr " " =
printf "Scan complete! Total number of URLs scanned: %s\n" "$count_urls" 
printf "Time taken: %s seconds.\n" "$F_TIME"
printf "%125s\n"| tr " " =

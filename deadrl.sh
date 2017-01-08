#!/usr/bin/env bash
# A simple URL status verifier
# version 0.0.1
clear
#suppressing errors, uncomment to debug
exec 2> /dev/null
URL_PATTERN="(http|https)://[^ ,\">'{}()!]+"
printf "%125s\n"| tr " " =
# LOGO :)
#colorizer
ESC="\033["
BOLD=$ESC"1m"
RESET=$ESC";0m"
RED=$'\e[1;31m'
MAG=$'\e[1;35m'
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
# arrays used to store urls based on the test
no_resp_urls=()
failed_urls=()
success_urls=()

echo -e "${BOLD}Scanning URLs in all *.rst and *.md documents in the current directory (recursive)${RESET}"
echo  -e "${BOLD}please wait, this will take few seconds...${RESET}"
echo -e "${BOLD}Results will be printed at the end.${RESET}"
printf "%125s\n"| tr " " =
# default search directory is the current directory
arg=.
if [ -n "${1}" ];then
	arg=$1
fi
TIMER_START=$SECONDS
# for each result in the regex grep output of URLs
# curl and see if we are getting a 200/300 status
for n in $`find $arg -name "*.rst" -o -name "*.md" | xargs grep -Erho "$URL_PATTERN"  | sort | uniq` :
do
	if [ "${#n}" -gt 2 ];then
		printf "${BOLD}Verifying URL${RESET}	${MAG}  =>${RESET}	%-s\n" $n
		stat=$(curl -Is $n -m 3 | head -n 1)
		if [ -z "${stat}" ];then
		no_resp_urls+=($n)
		fi
		if [ -n "${stat}" ];then
		IFS=" " read -a s_code <<< "$stat"
			if [ "${s_code[1]}" -gt 399 ];then
				failed_urls+=($n)
			else
				success_urls+=($n)
			fi
		fi
	fi
done

s_count=0
f_count=0
n_count=0
TOTAL_TIME=$(( SECONDS - TIME_START ))
printf "%125s\n"| tr " " =
printf "%125s\n\n"| tr " " =
printf "\nResults ::\n"
printf "${MAG}URLs that responded with 2XX or 3XX (success) ::${RESET}\n"
for s in ${success_urls[@]}:
do
	let s_count+=1
	printf "%s\n" "$s"
done
printf "\n%125s\n\n"| tr " " -
printf "${RED}URLs that responded with 4XXs ::${RESET}\n"
for f in ${failed_urls[@]}:
do
	let f_count+=1
	printf "%s\n" "$f"
done

printf "\n%125s\n\n"| tr " " -
printf "${RED}URLs that did not return any response ::${RESET}\n"
for n in ${no_resp_urls[@]}:
do
	let n_count+=1
	printf "%s\n" "$n"
done

let count=s_count+f_count+n_count
printf "%125s\n"| tr " " =
printf "Scanning complete! Total time taken: %s seconds.\n" "$TOTAL_TIME"
printf "${BOLD}Number of URLs that returned 2xx or 3xx:: %s${RESET}" $s_count
printf "\n${BOLD}Number of URLs that returned 4xx:: %s${RESET}" $f_count
printf "\n${BOLD}Number of URLs that returned no response::%s${RESET}" $n_count
printf "\n${BOLD}Total number of URLs scanned:: %s${RESET}\n" $count
printf "%125s\n"| tr " " =

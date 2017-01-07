#!/usr/bin/env bash
# A simple URL status verifier
# version 0.0.1
clear
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
# arrays used to store urls based on the test
no_resp_urls=()
failed_urls=()
success_urls=()
# default search directory is the current directory
arg=.
if [ -n "${1}" ];then
	arg=$1
fi
echo -e "${BOLD}Scanning URLs in all *.rst and *.md documents in the current directory (recursive)${RESET}"
echo  -e "${BOLD}please wait, this will take few seconds...${RESET}"
echo -e "${BOLD}Results will be printed at the end.${RESET}"
 printf "%125s\n"| tr " " =
url_array=(`find $arg -name "*.rst" -o -name "*.md" | xargs  grep -Erho "$URL_PATTERN"  | sort | uniq`)
check_url () {
	n=$1
	#printf "argument inside check_url is" "$n\n"
	if [ "${#n}" -gt 2 ];then
		printf "${BOLD}Verifying URL${RESET}	${MAG}  =>${RESET}	%-s\n" $n
		stat=$(curl -Is -m4 -X HEAD  $n| head -n 2)
		printf "$stat"
		if [ -z "${stat}" ];then
			no_resp_urls+=($n)
		fi
		if [ -n "${stat}" ];then
			IFS=" " read -a s_code <<< "$stat"
			printf "Scode is $scode\n"
			if [ "${s_code[1]}" -gt 399 ];then
				failed_urls+=($n)
			else
				success_urls+=($n)
			fi
		fi
	fi
}
export -f check_url
 printf "%s\n" "${url_array[@]}" | xargs  -I {} -P 1  bash -c "check_url  {} $@"
s_count=0
f_count=0
n_count=0
printf "%125s\n"| tr " " =
printf "Scanning complete!\n"
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
printf "${BOLD}Number of URLs that returned 2xx or 3xx:: %s${RESET}" $s_count
printf "\n${BOLD}Number of URLs that returned 4xx:: %s${RESET}" $f_count
printf "\n${BOLD}Number of URLs that returned no response::%s${RESET}" $n_count
printf "\n${BOLD}Total number of URLs scanned:: %s${RESET}\n" $count
printf "%125s\n"| tr " " =
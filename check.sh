#!/usr/bin/env bash
printf "%100s\n"| tr " " -
# for each result in the regex grep output of URLs
# curl and see if we are getting a 200/300 status
no_resp_urls=()
failed_urls=()
success_urls=()
echo  "Verifying if URLs in *.rst and *.md documents are valid, please wait, will take few seconds..."
for n in $`find . -name "*.rst" -o -name "*.md" | xargs grep -Erho "(http|https)://[^ ,\">'{}]+"  | sort | uniq` :
do
	stat=$(curl -Is $n -m 3 | head -n 1)
	if [ -z "${stat}" ];then
		no_resp_urls+=($n)
	fi
	if [ -n "${stat}" ];then
		s_code=$stat | cut -d " " -f 2
		if $s_code > 399;then
			failed_urls+=($n)
		else
			success_urls+=($n)
		fi
	fi
done

printf "%100s\n"| tr " " -
printf "URLs that responded with 2XX or 3XX (success) ::"
for s in ${success_urls[@]}:
do
	printf "%s\n" "$s"
done

printf "%100s\n"| tr " " -
printf "URLs that responded with 4XXs ::"
for f in ${failed_urls[@]}:
do
	printf "%s\n" "$f"
done

printf "%100s\n"| tr " " -
printf "URLs that did not return any response ::\n"
for n in ${no_resp_urls[@]}:
do
	printf "%s\n" "$n"
done
printf "%100s\n"| tr " " -

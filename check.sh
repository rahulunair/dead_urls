echo "---------------------------------"
for n in $`grep -Erho "(http|https)://[^ ,\">'{}]+$" *.sh | sort | uniq`:
do
	echo -n $n ::
	curl -Is $n | head -n 1
done
echo "---------------------------------"

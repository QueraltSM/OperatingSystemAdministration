#!/bin/bash
oldCount=0

for file in $(ls /home/centoslive/Desktop/)
do
	newCount=$(cat $file | grep -c "user")
	echo $newCount
	if [[ $oldCount -lt $newCount ]]
	then
		oldCount=$newCount
		path=$file
		echo $oldCount
	fi
done 
if [[ $oldCount -gt 0 ]]
then
	echo "$path with $oldCount"
else
	echo "None"
fi
exit 0

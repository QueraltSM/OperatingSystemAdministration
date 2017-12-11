#!/bin/bash
function calculateUsers(){
count=0
file=$(cat /etc/passwd | cut -f1 -d':')
	for user in $file 
	do
		line=$(chage -l $user | sed -n '4p')
		if [ -z $(echo $line | grep -q newer) ]
		then
			(( count++ ))
		fi
	done
echo "There is $count users with password which expires."
}

calculateUsers
exit 0 

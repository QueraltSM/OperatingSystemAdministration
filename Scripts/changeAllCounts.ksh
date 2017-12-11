#!/bin/bash
while read line
do
	if [[ $(echo $line | cut -f1 -d':') == "temp" ]]
	then	
		users=$(echo $line | cut -f4 -d':' | tr ',' '\n')
		for user in $users
		do	
			chage -E 2017-09-01 $user

		done
		
	fi
done < /etc/group
exit 0

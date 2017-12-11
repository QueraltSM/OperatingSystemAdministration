#!/bin/bash
function check(){
count=0
echo "$(cat /etc/passwd | cut -d':' -f1)" > fileUsers
echo "$(cat /etc/group | cut -d':' -f4 | tr -d ',')" > fileAdmins

	for line in $(cat fileUsers)
	do
		for line2 in $(cat fileAdmins)
		do	
			if [[ $line == $line2 ]]
			then
				(( count++ ))
			fi
		done
		
		if [[ "$count" -gt "$1" ]]
		then
			echo "$line is owner of more than $1 groups. ($count)"
		fi
	done
	rm fileUsers
	rm fileAdmins
}

if (( $# == 1 ))
then
	check $1
	exit 0
	
else
	echo "Error. Insufficient arguments."

fi

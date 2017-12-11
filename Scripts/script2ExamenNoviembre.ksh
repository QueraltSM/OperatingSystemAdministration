#!/bin/bash
function readFile() {
count=0
	while read line
	do
		if [[ $(echo $(stat -c "%U" $line)) == $1 ]]
		then
			(( count++ ))
		fi
	done < $2
	echo "$1 has $count files in common"
}

function userExists() {
	cat /etc/passwd | cut -d: -f1 | while read user
	do
		if [ $user == $1 ];
		then
			readFile $*
		fi
	done
}


if (( $# == 2 ))
then
	userExists $*
	exit 0

else
	echo "Error, insufficient arguments."
	exit 1
fi

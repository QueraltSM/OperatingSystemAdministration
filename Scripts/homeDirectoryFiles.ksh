#!/bin/bash
function findFileIn(){
	for file in $*
	do
		for directory in $home
		do 
			if [[ $(find /$directory -iname $file) ]]	
			then
				echo $file
			fi
		done
	done
}

if (( $# != 0 ))
then
	while read user
	do
		if [[ $(echo $user | cut -f3 -d':') -gt 500 ]]
		then
			home=$(echo $user | cut -f6 -d':')
			findFileIn $*
		fi

	done < /etc/passwd
	exit 0
else

	echo "Error. Insufficient arguments."
	exit 1
fi
